import gym
import collections
import random
import torch
import torch.nn as nn
import torch.optim as optim
import yaml

# Assuming the existence of other models and adapters
from models import DQN, PPO, A3C, ACER  
from adapters import DQN2PPO, PPO2A3C, A3C2ACER

class ReplayBuffer():
    def __init__(self):
        self.buffer = collections.deque(maxlen=buffer_limit)
    
    def put(self, transition):
        self.buffer.append(transition)
    
    def sample(self, n):
        mini_batch = random.sample(self.buffer, n)
        s_lst, a_lst, r_lst, s_prime_lst, done_mask_lst = [], [], [], [], []
        
        for transition in mini_batch:
            s, a, r, s_prime, done_mask = transition
            s_lst.append(s)
            a_lst.append([a])
            r_lst.append([r])
            s_prime_lst.append(s_prime)
            done_mask_lst.append([done_mask])

        return torch.tensor(s_lst, dtype=torch.float), torch.tensor(a_lst), \
               torch.tensor(r_lst), torch.tensor(s_prime_lst, dtype=torch.float), \
               torch.tensor(done_mask_lst)
    
    def size(self):
        return len(self.buffer)

class Qnet(nn.Module):
    def __init__(self):
        super(Qnet, self).__init__()
        self.fc1 = nn.Linear(4, 128)
        self.fc2 = nn.Linear(128, 128)
        self.fc3 = nn.Linear(128, 2)

    def forward(self, x):
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x
      
    def sample_action(self, obs, epsilon):
        out = self.forward(obs)
        coin = random.random()
        if coin < epsilon:
            return random.randint(0,1)
        else : 
            return out.argmax().item()

class NeoDQN(Qnet):
    def __init__(self, environment, model_chain, learning_rate=0.0005, gamma=0.98):
        super().__init__()
        self.env = gym.make(environment)
        self.model_chain = model_chain
        self.optimizer = optim.Adam(self.parameters(), lr=learning_rate)
        self.gamma = gamma
        self.memory = ReplayBuffer()
        self.yaml_file = self.init_yaml()

    def init_yaml(self):
        # Initialize a new YAML file
        yaml_file = {'chain_name': 'NeoDQN-extended-chain', 'models': [], 'decisions': []}
        return yaml_file

    def update_yaml(self, model_name, metadata):
        # Update YAML file with new data
        self.yaml_file['models'].append(model_name)
        self.yaml_file['decisions'].append(metadata)

    def process_chain(self, state, epsilon):
        # Process the chain of models and adapters
        current_input = state
        for model_or_adapter in self.model_chain:
            output, metadata = model_or_adapter.process(current_input, epsilon)
            self.update_yaml(model_or_adapter.__class__.__name__, metadata)
            current_input = output
        return current_input

    def train(self, episodes):
        for episode in range(episodes):
            state = self.env.reset()
            done = False
            while not done:
                action = self.sample_action(torch.from_numpy(state).float(), epsilon)
                next_state, reward, done, _ = self.env.step(action)
                self.memory.put((state, action, reward/100.0, next_state, done_mask))
                state = next_state

                if self.memory.size() > 2000:
                    self.train_qnet()

            # Save YAML file after each episode
            with open('chain_metadata.yaml', 'w') as file:
                yaml.dump(self.yaml_file, file)

            # Reset YAML for the next episode
            self.yaml_file = self.init_yaml()

    def train_qnet(self):
        # Training logic for Qnet (same as in the raw DQN)

# Example usage
model_chain = [DQN2PPO(), PPO(), PPO2A3C(), A3C(), A3C2ACER(), ACER()]
neo_dqn = NeoDQN(environment='NLE-env', model_chain=model_chain)
neo_dqn.train(episodes=1000)

# Note: Original file path - inkedYogi/minimalRL/dqn.py
 
