# List of function definitions from the notebook
program_functions = [
    time_execution, zero_mapping, matrix_by_name, tensor_product_by_name, 
    solve_quadratic, distance_3d, distance_from_origin, n_flat_dist, 
    non_euclidean_distance, remove_extension, trans, get_file_from_github, 
    criteria_function, prepare_data, makeYaml, plot_data, calc_half_life, 
    calc_reaction_rate, determine_charge, get_bond_energy, hamming_distance, 
    is_complement_palindrome, is_dna_palindrome, complement_dna_strand, 
    generate_rna_strand, assemble_beep_alert, play_beep_alert, peek_library, 
    assemble_function_list, scribe_file
]

module_functions = [
    zero_mapping, matrix_by_name, tensor_product_by_name, 
    solve_quadratic, distance_3d, distance_from_origin, n_flat_dist, 
    non_euclidean_distance, trans, 
    prepare_data, makeYaml, plot_data, calc_half_life, 
    calc_reaction_rate, determine_charge, get_bond_energy, hamming_distance, 
    is_complement_palindrome, is_dna_palindrome, complement_dna_strand, 
    generate_rna_strand
]

core_program_functions = [
    time_execution, remove_extension, get_file_from_github, 
    criteria_function, assemble_beep_alert, play_beep_alert, peek_library, 
    assemble_function_list, scribe_file
]
# List of functions with all included internal variable names
time_execution(func, start_time, result, end_time, execution_time)

zero_mapping(initial_state, transform, final_state, tolerance, verbose, zero_map, zero_sum)

matrix_by_name(a, matrix_a)

tensor_product_by_name(a, b, v, expression, result)

solve_quadratic(a, b, c, discriminant, root1, root2, root, real_part, imaginary_part)

distance_3d(point1, point2)

distance_from_origin(x, y)

n_flat_dist(coordinates)

non_euclidean_distance(x, y, d, euclidean_distance)

remove_extension(filename)

trans(x, y, z, a, b, c, origin, translated_coord)

get_file_from_github(repo_owner, repo_name, file_path, token, write_file, raw_url, headers, response, local_filename, file)

criteria_function(value, criteria_list)

prepare_data(file_name, data)

makeYaml(data, plot_title, yaml_filename, default_style, file)

plot_data(data, style_yaml, x_column, y_column, file, style)

calc_half_life(mass, half_lives)

calc_reaction_rate(A0, k, n)

determine_charge(electrons, protons)

get_bond_energy(bond_type, bonds_charted)

hamming_distance(dna1, dna2)

is_complement_palindrome(dna, complement_sequence)

is_dna_palindrome(sequence)

complement_dna_strand(dna_strand, opposite_strand)

generate_rna_strand(dna_strand, generated_strand)

assemble_beep_alert(beep, combined_beep)

play_beep_alert()

peek_library(library, item)

assemble_function_list(function_names, function_list_text, func, function_name, arguments)

scribe_file(txt_file_name, text_list, text_file)

# Current Working Dictionaries:

named_matrices = {
        '0': np.array([[ 0,  0], [ 0,  0]]),
        'ε': np.array([[0, 1], [0, 0]]),
        '-ε': np.array([[0, -1], [0, 0]]),
        'λ': np.array([[0, 0], [1, 0]]),
        '-λ': np.array([[0, 0], [-1, 0]]),
        'η': np.array([[0, -1], [0, 0]]),
        '-η': np.array([[0, 1], [0, 0]]),
        'τ': np.array([[0, 0], [-1, 0]]),
        '-τ': np.array([[0, 0], [1, 0]]),
        '1': np.array([[ 1,  0], [ 0,  1]]),
        '-1': np.array([[ -1,  0], [ 0,  -1]]),
        'i': np.array([[ 0,  1], [-1,  0]]),
        '-i': np.array([[ 0, -1], [ 1,  0]]),
        'j': np.array([[ 0,  1], [ 1,  0]]),
        'k': np.array([[-1,  0], [ 0,  1]]),
        '-j': np.array([[ 0, -1], [-1,  0]]),
        '-k': np.array([[ 1,  0], [ 0, -1]]),
        't': np.array([[ 0, -1], [-1,  0]]),
        'u': np.array([[ 0, -1], [ 1,  0]]),
        'v': np.array([[-1,  0], [ 0, -1]]),
        'w': np.array([[ 1,  0], [ 0, -1]]),
        '-t': np.array([[ 0,  1], [ 1,  0]]),
        '-u': np.array([[ 0,  1], [-1,  0]]),
        '-v': np.array([[ 1,  0], [ 0,  1]]),
        '-w': np.array([[-1,  0], [ 0,  1]])
    }

chemical_elements = {
    1:  {'symbol': 'H', 'atomic_mass': 1.008},
    2:  {'symbol': 'He', 'atomic_mass': 4.0026},
    3:  {'symbol': 'Li', 'atomic_mass': 6.94},
    4:  {'symbol': 'Be', 'atomic_mass': 9.0122},
    5:  {'symbol': 'B', 'atomic_mass': 10.81},
    6:  {'symbol': 'C', 'atomic_mass': 12.011},
    7:  {'symbol': 'N', 'atomic_mass': 14.007},
    8:  {'symbol': 'O', 'atomic_mass': 15.999},
    9:  {'symbol': 'F', 'atomic_mass': 18.998},
    10: {'symbol': 'Ne', 'atomic_mass': 20.180},
    11: {'symbol': 'Na', 'atomic_mass': 22.990},
    12: {'symbol': 'Mg', 'atomic_mass': 24.305},
    13: {'symbol': 'Al', 'atomic_mass': 26.982},
    14: {'symbol': 'Si', 'atomic_mass': 28.085},
    15: {'symbol':  'P', 'atomic_mass': 30.974},
    16: {'symbol':  'S', 'atomic_mass': 32.06},
    17: {'symbol': 'Cl', 'atomic_mass': 35.45},
    18: {'symbol': 'Ar', 'atomic_mass': 39.948},
    19: {'symbol':  'K', 'atomic_mass': 39.098},
    20: {'symbol': 'Ca', 'atomic_mass': 40.078},
    21: {'symbol': 'Sc', 'atomic_mass': 44.956},
    22: {'symbol': 'Ti', 'atomic_mass': 47.867},
    23: {'symbol':  'V', 'atomic_mass': 50.942},
    24: {'symbol': 'Cr', 'atomic_mass': 51.996},
    25: {'symbol': 'Mn', 'atomic_mass': 54.938},
    26: {'symbol': 'Fe', 'atomic_mass': 55.845},
    27: {'symbol': 'Co', 'atomic_mass': 58.933},
    28: {'symbol': 'Ni', 'atomic_mass': 58.693},
    29: {'symbol': 'Cu', 'atomic_mass': 63.546},
    30: {'symbol': 'Zn', 'atomic_mass': 65.38},
    31: {'symbol': 'Ga', 'atomic_mass': 69.723},
    32: {'symbol': 'Ge', 'atomic_mass': 72.630},
    33: {'symbol': 'As', 'atomic_mass': 74.922},
    34: {'symbol': 'Se', 'atomic_mass': 78.971},
    35: {'symbol': 'Br', 'atomic_mass': 79.904},
    36: {'symbol': 'Kr', 'atomic_mass': 83.798},
    37: {'symbol': 'Rb', 'atomic_mass': 85.468},
    38: {'symbol': 'Sr', 'atomic_mass': 87.62},
    39: {'symbol':  'Y', 'atomic_mass': 88.906},
    40: {'symbol': 'Zr', 'atomic_mass': 91.224},
    41: {'symbol': 'Nb', 'atomic_mass': 92.906},
    42: {'symbol': 'Mo', 'atomic_mass': 95.95},
    43: {'symbol': 'Tc', 'atomic_mass': 98.0},
    44: {'symbol': 'Ru', 'atomic_mass': 101.07},
    45: {'symbol': 'Rh', 'atomic_mass': 102.91},
    46: {'symbol': 'Pd', 'atomic_mass': 106.42},
    47: {'symbol': 'Ag', 'atomic_mass': 107.87},
    48: {'symbol': 'Cd', 'atomic_mass': 112.41},
    49: {'symbol': 'In', 'atomic_mass': 114.82},
    50: {'symbol': 'Sn', 'atomic_mass': 118.71},
    51: {'symbol': 'Sb', 'atomic_mass': 121.76},
    52: {'symbol': 'Te', 'atomic_mass': 127.60},
    53: {'symbol':  'I', 'atomic_mass': 126.90},
    54: {'symbol': 'Xe', 'atomic_mass': 131.29},
    55: {'symbol': 'Cs', 'atomic_mass': 132.91},
    56: {'symbol': 'Ba', 'atomic_mass': 137.33},
    57: {'symbol': 'La', 'atomic_mass': 138.91},
    58: {'symbol': 'Ce', 'atomic_mass': 140.12},
    59: {'symbol': 'Pr', 'atomic_mass': 140.91},
    60: {'symbol': 'Nd', 'atomic_mass': 144.24},
    61: {'symbol': 'Pm', 'atomic_mass': 145.0},
    62: {'symbol': 'Sm', 'atomic_mass': 150.36},
    63: {'symbol': 'Eu', 'atomic_mass': 151.96},
    64: {'symbol': 'Gd', 'atomic_mass': 157.25},
    65: {'symbol': 'Tb', 'atomic_mass': 158.93},
    66: {'symbol': 'Dy', 'atomic_mass': 162.50},
    67: {'symbol': 'Ho', 'atomic_mass': 164.93},
    68: {'symbol': 'Er', 'atomic_mass': 167.26},
    69: {'symbol': 'Tm', 'atomic_mass': 168.93},
    70: {'symbol': 'Yb', 'atomic_mass': 173.05},
    71: {'symbol': 'Lu', 'atomic_mass': 174.97},
    72: {'symbol': 'Hf', 'atomic_mass': 178.49},
    73: {'symbol': 'Ta', 'atomic_mass': 180.95},
    74: {'symbol':  'W', 'atomic_mass': 183.84},
    75: {'symbol': 'Re', 'atomic_mass': 186.21},
    76: {'symbol': 'Os', 'atomic_mass': 190.23},
    77: {'symbol': 'Ir', 'atomic_mass': 192.22},
    78: {'symbol': 'Pt', 'atomic_mass': 195.08},
    79: {'symbol': 'Au', 'atomic_mass': 196.97},
    80: {'symbol': 'Hg', 'atomic_mass': 200.59},
    81: {'symbol': 'Tl', 'atomic_mass': 204.38},
    82: {'symbol': 'Pb', 'atomic_mass': 207.2},
    83: {'symbol': 'Bi', 'atomic_mass': 208.98},
    84: {'symbol': 'Po', 'atomic_mass': 209.0},
    85: {'symbol': 'At', 'atomic_mass': 210.0},
    86: {'symbol': 'Rn', 'atomic_mass': 222.0},
    87: {'symbol': 'Fr', 'atomic_mass': 223.0},
    88: {'symbol': 'Ra', 'atomic_mass': 226.0},
    89: {'symbol': 'Ac', 'atomic_mass': 227.0},
    90: {'symbol': 'Th', 'atomic_mass': 232.04},
    91: {'symbol': 'Pa', 'atomic_mass': 231.04},
    92: {'symbol':  'U', 'atomic_mass': 238.03},
    93: {'symbol': 'Np', 'atomic_mass': 237.0},
    94: {'symbol': 'Pu', 'atomic_mass': 244.0},
    95: {'symbol': 'Am', 'atomic_mass': 243.0},
    96: {'symbol': 'Cm', 'atomic_mass': 247.0},
    97: {'symbol': 'Bk', 'atomic_mass': 247.0},
    98: {'symbol': 'Cf', 'atomic_mass': 251.0},
    99: {'symbol': 'Es', 'atomic_mass': 252.0},
    100: {'symbol': 'Fm','atomic_mass': 257.0}
    }                                                                               # (Z)Atomic Number, Atomic Symbol, Atomic Weight

chemical_compounds = [
             'HCl',
             'NaOH',
             'KCl',
             'H2SO4',
             'Ca(OH)2',
             'KOH',
             'HNO3',
             'Na2SO4',
             'KNO3',
             'Mg(OH)2',
             'HCO2H',
             'NaBr'
              ]

bonds_charted = {
    "C-C": 345,      # Single bond between carbon atoms
    "C=C": 611,      # Double bond between carbon atoms
    "C≡C": 837,      # Triple bond between carbon atoms
    "C-H": 413,      # Single bond between carbon and hydrogen
    "C-O": 358,      # Single bond between carbon and oxygen
    "C=O": 745,      # Double bond between carbon and oxygen
    "O-H": 467,      # Single bond between oxygen and hydrogen
    "N-H": 391,      # Single bond between nitrogen and hydrogen
    "N=N": 418,      # Double bond between nitrogen atoms
    "O-O": 142,      # Single bond between oxygen atoms
    "N-O": 201,      # Single bond between nitrogen and oxygen
    "N=O": 602,      # Double bond between nitrogen and oxygen
    "H-H": 432,      # Single bond between hydrogen atoms
    "C-N": 292,      # Single bond between carbon and nitrogen
    "C≡N": 891,      # Triple bond between carbon and nitrogen
    "S-H": 339,      # Single bond between sulfur and hydrogen
    "S-S": 266,      # Single bond between sulfur atoms
    "P-H": 323,      # Single bond between phosphorus and hydrogen
    "P-P": 201,      # Single bond between phosphorus atoms
    "H-F": 565,      # Single bond between hydrogen and fluorine
    "C-Cl": 330,     # Single bond between carbon and chlorine
    "C-Br": 276,     # Single bond between carbon and bromine
    "C-I": 213,      # Single bond between carbon and iodine
    "Si-H": 318,     # Single bond between silicon and hydrogen
    # Add more as needed...
      }
                                                                           # A dictionary associating your bond notation with the energy value

amino_acid = {
    'A': 'Ala',
    'R': 'Arg',
    'N': 'Asn',
    'D': 'Asp',
    'C': 'Cys',
    'E': 'Glu',
    'Q': 'Gln',
    'G': 'Gly',
    'H': 'His',
    'I': 'Ile',
    'L': 'Leu',
    'K': 'Lys',
    'M': 'Met',
    'F': 'Phe',
    'P': 'Pro',
    'S': 'Ser',
    'T': 'Thr',
    'W': 'Trp',
    'Y': 'Tyr',
    'V': 'Val'
  }
