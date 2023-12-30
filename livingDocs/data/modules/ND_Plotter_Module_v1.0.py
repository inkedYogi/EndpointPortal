# ND_Plotter_Module v1.0

def plotter_module():
    global data_title
    new_title = input("Enter title for data: ")
    data_title = new_title
    get_file_from_github(owner, target_repo, folder+file_to_load, token)
    data = prepare_data(file_to_load)
    makeYaml(data, data_title)
    plot_data(data, 'plot_style.yaml')
    
def makeYaml(data, plot_title = 'Default Name', yaml_filename='plot_style.yaml'):
    default_style = {
        'figure_size': [6, 4],
        'plot_type': 'line',  # Default plot type
        'x_column': data.columns[0],
        'y_column': data.columns[1],
        'x_label': data.columns[0],
        'y_label': data.columns[1],
        'title': plot_title,
        'grid': True
    }

    with open(yaml_filename, 'w') as file:
        yaml.dump(default_style, file)

    print(f"Default YAML file '{yaml_filename}' created.")

def prepare_data(file_name):
    if file_name.endswith('.csv'):
        data = pd.read_csv(file_name)
    elif file_name.endswith('.txt'):
        # Add logic for .txt file processing
        data = pd.read_table(file_name)
    elif file_name.endswith('.md'):
        # Add logic for .md file processing
        pass  # Markdown files usually don't contain plottable data
    else:
        raise ValueError("Unsupported file type.")
    return data

def plot_data(data, style_yaml, x_column=None, y_column=None):
    with open(style_yaml, 'r') as file:
        style = yaml.safe_load(file)

    # Determine columns to plot
    if x_column is None or y_column is None:
        x_column, y_column = data.columns[:2]

    plt.figure(figsize=style.get('figure_size', (10, 6)))
    if style.get('plot_type') == 'line':
        plt.plot(data[x_column], data[y_column])
    elif style.get('plot_type') == 'stem':
        plt.stem(data[x_column], data[y_column], markerfmt=style.get('markerfmt', 'o'))

    plt.xlabel(style.get('x_label', x_column))
    plt.ylabel(style.get('y_label', y_column))
    plt.title(style.get('title', 'Plot'))
    plt.grid(style.get('grid', True))
    plt.show()
