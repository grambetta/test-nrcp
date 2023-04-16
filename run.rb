require_relative 'app'

path = './logs/*' # Path to the logfiles
parameter = 'id'  # The parameter you are looking for
size = 5          # Number of top  you are

find_max_values(path, parameter, size)
