# DNA_Module v1.0

def hamming_distance(dna1, dna2):
    """ Calculate the Hamming distance between two DNA sequences. """
    # Check if the lengths of the sequences are the same
    if len(dna1) != len(dna2):
        return "Error: Sequences are not of the same length."

    # Calculate Hamming distance
    return sum(base1 != base2 for base1, base2 in zip(dna1, dna2))

def is_complement_palindrome(dna):
    complement = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G'}
    complement_sequence = ''.join([complement[nucleotide] for nucleotide in dna])
    return dna == complement_sequence[::-1]

def is_dna_palindrome(sequence):
    return sequence == sequence[::-1]

def complement_dna_strand(dna_strand):
    """
    Generates the complementary DNA ssequence for a given DNA strand.
    Parameters:
    dna_strand (str): A string representing a DNA strand composed of 'A', 'T', 'G', and 'C'.
    Returns:
    str: The complementary DNA strand.
    """
    complement = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G'}
    opposite_strand = ''.join([complement[nucleotide] for nucleotide in dna_strand])
    return opposite_strand

def generate_rna_strand(dna_strand):
    """
    Generates the complementary DNA ssequence for a given DNA strand.
    Parameters:
    dna_strand (str): A string representing a DNA strand composed of 'A', 'T', 'G', and 'C'.
    Returns:
    str: The complementary DNA strand.
    """
    rna_complement = {'A': 'U', 'T': 'A', 'G': 'C', 'C': 'G'}
    generated_strand = ''.join([rna_complement[nucleotide] for nucleotide in dna_strand])
    return generated_strand
