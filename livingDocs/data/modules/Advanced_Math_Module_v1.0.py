# Advanced_Math_Module v1.0

def zero_mapping(initial_state, transform, final_state, tolerance=1e-6, verbose=False):
    """
    Compares the transformed initial state with the final state using zero mapping.

    Parameters:
    initial_state (list/tuple): The initial state before transformation.
    transform (list/tuple): The transformation applied to the initial state.
    final_state (list/tuple): The final state to compare against.
    tolerance (float): The numerical tolerance for considering values as zero.
    verbose (bool): If True, prints detailed output.

    Returns:
    bool: True if the zero sum is within the specified tolerance, otherwise False.
    """
    zero_map = [f - (x + t) for f, t, x in zip(final_state, transform, initial_state)]
    zero_sum = sum(zero_map)

    if verbose:
        print(f"Zero map: {zero_map}")
        print(f"Zero Sum: {zero_sum}")

    if abs(zero_sum) < tolerance:
        if verbose:
            print("Success! The zero sum is within tolerance.")
        return True
    else:
        if verbose:
            print("Failure! The zero sum is outside tolerance.")
        return False

def matrix_by_name(a):
    # Mapping from characters to 2x2 matrices
    matrix_a = named_matrices.get(a)
    return matrix_a

def tensor_product_by_name(a, b, v=None):
    # Retrieve the corresponding matrices
    expression = f"{a} ⊗ {b}"
    # matrix_a = matrix_by_name(a)
    if (v):  print(f"a: \n{matrix_by_name(a)}")
    # matrix_b = matrix_by_name(b)
    if(v):  print(f"b: \n{matrix_by_name(b)}\n")

    # Calculate the tensor product
    result = np.kron(matrix_by_name(a),matrix_by_name(b))
    if(v):  print(f"a ⊗ b: \n{result}\n")
    return result,expression

def solve_quadratic(a, b, c):
    """
    Solve a quadratic equation of the form ax^2 + bx + c = 0 and determine the nature of its roots.
    Parameters:
    a (float): Coefficient of x^2.
    b (float): Coefficient of x.
    c (float): Constant term.
    Returns:
    tuple: A tuple containing the roots and a string describing the nature of the roots.
    """
    discriminant = b**2 - 4*a*c

    if discriminant > 0:
        root1 = (-b + math.sqrt(discriminant)) / (2 * a)
        root2 = (-b - math.sqrt(discriminant)) / (2 * a)
        return (root1, root2), "real and distinct"
    elif discriminant == 0:
        root = -b / (2 * a)
        return (root,), "real and repeated"
    else:
        real_part = -b / (2 * a)
        imaginary_part = math.sqrt(-discriminant) / (2 * a)
        return (real_part + imaginary_part*1j, real_part - imaginary_part*1j), "imaginary"

def distance_3d(point1, point2):
    # Function to calculate Euclidean distance between two points in 3D
    return math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2 + (point1[2] - point2[2])**2)

def distance_from_origin(x, y):
    """
    Calculate the euclidean distance of a point from the origin on an xy-plane.
    Parameters:
    x (float): x-coordinate of the point.
    y (float): y-coordinate of the point.
    Returns:
    float: Distance of the point from the origin.
    """
    return math.hypot(x, y)

def n_flat_dist(*coordinates):
    """ Calculate the distance from the origin to a point in n-dimensional space. """
    return math.sqrt(sum(x**2 for x in coordinates))

def non_euclidean_distance(x, y, d):
    """
    Calculate the non-Euclidean distance of a point from the origin on an xy-plane.
    Parameters:
    x (float): x-coordinate of the point.
    y (float): y-coordinate of the point.
    d (float): Defect that represents the curvature of the space.
    Returns:
    float: Non-Euclidean distance of the point from the origin.
    """
    euclidean_distance = math.hypot(x, y)
    return euclidean_distance + d

def trans(x=0, y=0, z=0, a=0, b=0, c=0):
    """
    Translates coordinates from the point (a, b, c) along the x, y, and z axes.

    Parameters:

    x (float): The amount to translate along the x-axis.
    y (float): The amount to translate along the y-axis.
    z (float): The amount to translate along the z-axis.
    a (float, optional): The intial x coordinate. Default 0
    b (float, optional): The intial y coordinate. Default 0
    c (float, optional): The intial z coordinate. Default 0

    Returns:
    tuple: The translated coordinates (a+x, b+y, c+z).
    """
    # Starting from the origin
    origin = (a, b, c)

    # Translate the coordinates
    translated_coord = (origin[0] + x, origin[1] + y, origin[2] + z)

    return translated_coord
