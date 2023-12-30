# Nuclear_Chemistry_Module v1.0

def calc_half_life(mass, half_lives=1):
    '''(float, hl=int) -> float
    Takes in mass and number of half-lives and returns
    remaining mass of material. Half-lives need to be
    integer values.
    '''
    mass /= 2
    half_lives -= 1
    if half_lives == 0:
        return mass
    else:
        return calc_half_life(mass, half_lives=half_lives)

def calc_reaction_rate(A0, k=1.0, n=1):
    """
    Calculate the rate of a chemical reaction using the differential rate law.

    Parameters:
    A0 (float): Concentration of reactant A in moles per liter (M).
    k (float, optional): Rate constant of the reaction. Default is 1.0.
    n (int, optional): Order of the reaction with respect to A. Default is 1.

    Returns:
    float: Rate of the reaction in M/s.
    """
    return k * (A0 ** n)

def determine_charge(electrons, protons):
    """
    Determines if a compound is cationic, anionic, or neutral.
    Parameters:
    electrons (int): The number of electrons in the compound.
    protons (int): The number of protons in the compound.
    Returns:
    str: The charge of the compound (Cationic, Anionic, or Neutral).
    """
    if electrons > protons:
        return 'Anionic'
    elif electrons < protons:
        return 'Cationic'
    else:
        return 'Neutral'

def get_bond_energy(bond_type, bonds_charted):
    """
    Retrieve the bond energy for a specified bond type from a given bond energy chart.
    Parameters:
    bond_type (str): The type of bond (e.g., "C-C", "C=C").
    bonds_charted (dict): A dictionary with bond types as keys and their energies as values.
    Returns:
    int: The energy of the specified bond, if it exists in the chart.
    """
    if bond_type in bonds_charted:
        return bonds_charted[bond_type]
    else:
        raise ValueError(f"Bond type '{bond_type}' not found in the bond energy chart.")
