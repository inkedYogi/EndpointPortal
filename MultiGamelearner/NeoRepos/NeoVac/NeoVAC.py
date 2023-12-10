import gym
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torch.distributions import Categorical
import yaml

# Hyperparameters
learning_rate = 0.0002
gamma = 0.98
n_rollout = 10

class NeoActorCritic(nn.Module):
    def __init__(self, environment):
        super(NeoActorCritic, self).__init__()
        self.env = gym.make(environment)
        self.data = []
        self.fc1 = nn.Linear(4, 256)
        self.fc_pi = nn.Linear(256, 2)
        self.fc_v = nn.Linear(256, 1)
        self.optimizer = optim.Adam(self.parameters(), lr=learning_rate)
        self.yaml_file = self.init_yaml()

    def init_yaml(self):
        # Initialize a new YAML file for the chain's metadata
        yaml_file = {'model_name': 'NeoActorCritic', 'decisions': []}
        return yaml_file

    def update_yaml(self, decision_metadata):
        # Update the YAML file with new data from the model
        self.yaml_file['decisions'].append(decision_metadata)

    def pi(self, x, softmax_dim=0):
        x = F.relu(self.fc1(x))
        x = self.fc_pi(x)
        prob = F.softmax(x, dim=softmax_dim)
        return prob

    def v(self, x):
        x = F.relu(self.fc1(x))
        v = self.fc_v(x)
        return v

    def put_data(self, transition):
        self.data.append(transition)

    def make_batch(self):
            s_lst, a_lst, r_lst, s_prime_lst, done_lst = [], [], [], [], []
            for transition in self.data:
                s,a,r,s_prime,done = transition
                s_lst.append(s)
                a_lst.append([a])
                r_lst.append([r/100.0])
                s_prime_lst.append(s_prime)
                done_mask = 0.0 if done else 1.0
                done_lst.append([done_mask])
            
            s_batch, a_batch, r_batch, s_prime_batch, done_batch = torch.tensor(s_lst, dtype=torch.float), torch.tensor(a_lst), \
                                                                   torch.tensor(r_lst, dtype=torch.float), torch.tensor(s_prime_lst, dtype=torch.float), \
                                                                   torch.tensor(done_lst, dtype=torch.float)
            self.data = []
            return s_batch, a_batch, r_batch, s_prime_batch, done_batch
      
    def train_net(self):
        s, a, r, s_prime, done = self.make_batch()
        td_target = r + gamma * self.v(s_prime) * done
        delta = td_target - self.v(s)
        
        pi = self.pi(s, softmax_dim=1)
        pi_a = pi.gather(1,a)
        loss = -torch.log(pi_a) * delta.detach() + F.smooth_l1_loss(self.v(s), td_target.detach())

        self.optimizer.zero_grad()
        loss.mean().backward()
        self.optimizer.step() 

def main():
    model = NeoActorCritic(environment='CartPole-v1')
    print_interval = 20
    score = 0.0

    for n_epi in range(10000):
        done = False
        s = model.env.reset()
        while not done:
            for t in range(n_rollout):
                prob = model.pi(torch.from_numpy(s).float())
                m = Categorical(prob)
                a = m.sample().item()
                s_prime, r, done, info = model.env.step(a)
                model.put_data((s, a, r, s_prime, done))
                
                # Update YAML with decision metadata
                decision_metadata = {'episode': n_epi, 'step': t, 'action': a}
                model.update_yaml(decision_metadata)

                s = s_prime
                score += r
                
                if done:
                    break                     
            
            model.train_net()
            
            if n_epi % print_interval == 0 and n_epi != 0:
                print("# of episode :{}, avg score : {:.1f}".format(n_epi, score / print_interval))
                score = 0.0
                
                # Save YAML file
                with open('actor_critic_metadata.yaml', 'w') as file:
                    yaml.dump(model.yaml_file, file)
                # Reset YAML for the next episode
                model.yaml_file = model.init_yaml()
    model.env.close()

if __name__ == '__main__':
    main()
