import gym
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torch.distributions import Categorical
import yaml

# Hyperparameters
learning_rate = 0.0005
gamma         = 0.98
lmbda         = 0.95
eps_clip      = 0.1
K_epoch       = 3
T_horizon     = 20

class NeoPPO(nn.Module):
    def __init__(self):
        super(NeoPPO, self).__init__()
        self.data = []
        
        self.fc1   = nn.Linear(4,256)
        self.fc_pi = nn.Linear(256,2)
        self.fc_v  = nn.Linear(256,1)
        self.optimizer = optim.Adam(self.parameters(), lr=learning_rate)

        # Initialize a YAML file for metadata management
        self.yaml_file = {'chain_name': 'NeoPPO-extended-chain', 'models': [], 'decisions': []}

    def pi(self, x, softmax_dim=0):
        x = F.relu(self.fc1(x))
        x = self.fc_pi(x)
        prob = F.softmax(x, dim=softmax_dim)
        return prob

    def v(self, x):
        x = F.relu(self.fc1(x))
        v = self.fc_v(x)
        return v

    # Existing PPO methods (put_data, make_batch, train_net) remain unchanged

    def update_yaml(self, model_name, metadata):
        # Update the YAML file with new data from the model
        self.yaml_file['models'].append(model_name)
        self.yaml_file['decisions'].append(metadata)

    def process_input(self, adapted_input):
        # Process the adapted input from DQN (via DQN2PPO)
        # Additional logic can be added here if necessary
        return adapted_input

    def train(self, episodes):
        env = gym.make('CartPole-v1')
        for n_epi in range(episodes):
            s, _ = env.reset()
            done = False
            while not done:
                for t in range(T_horizon):
                    adapted_s = self.process_input(torch.from_numpy(s).float())
                    prob = self.pi(adapted_s)
                    m = Categorical(prob)
                    a = m.sample().item()
                    s_prime, r, done, info = env.step(a)

                    self.put_data((s, a, r/100.0, s_prime, prob[a].item(), done))
                    s = s_prime

                    score += r
                    if done:
                        break

                self.train_net()
                self.update_yaml('NeoPPO', {'episode': n_epi, 'score': score})

            if n_epi % print_interval == 0 and n_epi != 0:
                print("# of episode :{}, avg score : {:.1f}".format(n_epi, score/print_interval))
                score = 0.0

            # Save YAML file after each episode
            with open('neo_ppo_metadata.yaml', 'w') as file:
                yaml.dump(self.yaml_file, file)

            # Reset YAML for the next episode
            self.yaml_file = {'chain_name': 'NeoPPO-extended-chain', 'models': [], 'decisions': []}

        env.close()

# Example usage
neo_ppo = NeoPPO()
neo_ppo.train(episodes=1000)
