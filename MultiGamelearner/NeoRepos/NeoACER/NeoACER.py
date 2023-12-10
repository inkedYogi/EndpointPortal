import gym
import random
import collections
import torch
import torch.nn as nn
import torch.optim as optim
from torch.distributions import Categorical
import yaml

# Assuming the existence of other models and adapters
from models import ActorCritic, A3C, ACER
from adapters import A3C2ACER

class NeoReplayBuffer():
    def __init__(self, buffer_limit):
        self.buffer = collections.deque(maxlen=buffer_limit)

    def put(self, seq_data):
        self.buffer.append(seq_data)

    def sample(self, on_policy=False):
        if on_policy:
            mini_batch = [self.buffer[-1]]
        else:
            mini_batch = random.sample(self.buffer, batch_size)

        s_lst, a_lst, r_lst, prob_lst, done_lst, is_first_lst = [], [], [], [], [], []
        for seq in mini_batch:
            is_first = True
            for transition in seq:
                s, a, r, prob, done = transition

                s_lst.append(s)
                a_lst.append([a])
                r_lst.append(r)
                prob_lst.append(prob)
                done_mask = 0.0 if done else 1.0
                done_lst.append(done_mask)
                is_first_lst.append(is_first)
                is_first = False

        s, a, r, prob, done_mask, is_first = torch.tensor(s_lst, dtype=torch.float), \
                                            torch.tensor(a_lst), r_lst, \
                                            torch.tensor(prob_lst, dtype=torch.float), \
                                            done_lst, is_first_lst
        return s, a, r, prob, done_mask, is_first

    def size(self):
        return len(self.buffer)

class NeoACER(ActorCritic):
    def __init__(self, environment, learning_rate=0.0002, gamma=0.98, buffer_limit=6000, rollout_len=10):
        super(NeoACER, self).__init__()
        self.env = gym.make(environment)
        self.optimizer = optim.Adam(self.parameters(), lr=learning_rate)
        self.memory = NeoReplayBuffer(buffer_limit)
        self.gamma = gamma
        self.rollout_len = rollout_len
        self.yaml_file = self.init_yaml()

    def init_yaml(self):
        # Initialize a new YAML file for the chain's metadata
        yaml_file = {'chain_name': 'NeoACER-extended-chain', 'models': [], 'decisions': []}
        return yaml_file

    def update_yaml(self, model_name, metadata):
        # Update the YAML file with new data from the model
        self.yaml_file['models'].append(model_name)
        self.yaml_file['decisions'].append(metadata)

    def train(self, episodes, on_policy=False):
        for episode in range(episodes):
            state = self.env.reset()
            done = False
            while not done:
                seq_data = []
                for t in range(self.rollout_len):
                    # Process input through the A3C2ACER adapter
                    output, metadata = A3C2ACER.process(state)
                    self.update_yaml('A3C2ACER', metadata)

                    action = self.select_action(output)
                    next_state, reward, done, _ = self.env.step(action)
                    seq_data.append((state, action, reward, next_state, done))

                    state = next_state
                    if done:
                        break

                self.memory.put(seq_data)
                if self.memory.size() > 500:
                    self.update_network(on_policy)

            # Save YAML file after each episode
            with open('chain_metadata.yaml', 'w') as file:
                yaml.dump(self.yaml_file, file)

            # Reset YAML for the next episode
            self.yaml_file = self.init_yaml()

    def select_action(self, state):
        prob = self.pi(torch.from_numpy(state).float())
        m = Categorical(prob)
        action = m.sample().item()
        return action, prob[action].item()

       def update_network(self, on_policy=False):
        s, a, r, prob, done_mask, is_first = self.memory.sample(on_policy)
        
        q_values = self.q(s)
        q_value = q_values.gather(1, a)
        pi = self.pi(s, softmax_dim=1)
        pi_a = pi.gather(1, a)
        v = (q_values * pi).sum(1).unsqueeze(1).detach()

        rho = pi.detach() / prob
        rho_a = rho.gather(1, a)
        rho_bar = rho_a.clamp(max=c)
        correction_coeff = (1 - c / rho).clamp(min=0)

        q_ret = v[-1] * done_mask[-1]
        q_ret_list = []
        for i in reversed(range(len(r))):
            q_ret = r[i] + gamma * q_ret
            q_ret_list.append(q_ret.item())
            q_ret = rho_bar[i] * (q_ret - q_value[i]) + v[i]
            if is_first[i] and i != 0:
                q_ret = v[i - 1] * done_mask[i - 1]

        q_ret_list.reverse()
        q_ret = torch.tensor(q_ret_list, dtype=torch.float).unsqueeze(1)

        loss1 = -rho_bar * torch.log(pi_a) * (q_ret - v)
        loss2 = -correction_coeff * pi.detach() * torch.log(pi) * (q_values.detach() - v)
        loss = loss1 + loss2.sum(1) + F.smooth_l1_loss(q_value, q_ret)

        self.optimizer.zero_grad()
        loss.mean().backward()
        self.optimizer.step()
         
# Example usage
neo_acer = NeoACER(environment='NLE-env')
neo_acer.train(episodes=1000)
