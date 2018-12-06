with open('test.gcode', 'r') as f:
    lines = f.readlines()

def getxy(line):
    vals = line.split()
    print line
    for i in vals:
        if i.startswith('X'):
            x = float(i[1:])
        if i.startswith('Y'):
            y = float(i[1:])
    try:
        print x,y
    except:
        print line

    return x,y

layers = []
layer = []
for line in lines:
    if line.startswith(';LAYER:'):
        # Find the smallest X and largest Y
        minx = 9999
        maxy = 0
        starter = 0
        print layer
        for idx, val in enumerate(layer):
            x,y = getxy(val)
            if x <= minx and y >= maxy:
                starter = idx
                minx = x
                maxy = y
        # append and clean up the layer
        sorted_layer = []
        sorted_layer.extend(layer[starter:])
        sorted_layer.extend(layer[:starter+1])
        layers.append(sorted_layer[:])
        layer = []
    if not line.startswith('G1 '):
        continue
    # Trim out speed and extruder commands
    trimmed_line = ' '.join([i for i in line.split() if 'G' in i or 'X' in i or 'Y' in i])
    if len(trimmed_line) > 2:
        layer.append(trimmed_line)

for idx, layer in enumerate(layers):
    with open('layer%s.gco' % idx, 'w') as f:
        f.write('G21\nG1 F40\nG90\n')
        for line in layer:
            f.write('%s\n' % line)
