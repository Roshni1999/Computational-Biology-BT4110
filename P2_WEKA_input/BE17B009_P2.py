#%%
# Code: Convert to arff format: Input file to WEKA

import numpy as np
import pandas as pd

#%%
# Parse fasta file
def read_fasta(fp):
    identifier = []; seqlist = []; flag = False; seq =[];
    with open(fp, 'r') as f:
        for line in f:
            if line.startswith(">"):
                identifier.append(line[1:-1].strip())
                if flag:
                    seqlist.append(''.join(seq))
                    seq = []
                else:
                    flag= True
                    seq= []
            else:
                seq.append(line[:-1].replace(' ', ''))
    seqlist.append(''.join(seq))
    seq = pd.DataFrame(identifier);
    seq['seq'] = seqlist
    seq.columns = ['identifier','seq']
    return seq
               

#%%
    
# AA composition
aa = {'A', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'Y'}
def AAcomposition(seq):
    composition = seq.seq.apply(lambda x: [x.count(y) for y in aa] ).values.tolist()
    composition = pd.DataFrame(np.array(composition), columns = aa)
    composition = composition.divide(composition.sum(axis=1).values, axis= 0)
    return composition

#%%
#Convert to arff file
def composition2arff(composition, filename):
    with open(filename, 'w') as outfile:
        outfile.write('@RELATION compos \n\n')
        
        for c in composition.columns[composition.columns != 'class']:
            str = '@ATTRIBUTE ' + c + ' NUMERIC \n'
            outfile.write(str)
        str = '@ATTRIBUTE class {' + ' , '.join(data_test['class'].unique().tolist()) + '}\n\n'
        outfile.write(str)
        
        outfile.write('@DATA\n')
        for line in composition.round(3).astype('str').values.tolist():
            str = ', '.join(line) + '\n'
            outfile.write(str)
    return True
#%%
test_split = 0.1

#%%
sequencesTMH = read_fasta("alphanr40.txt")
sequencesTMB = read_fasta("betanr40.txt")

alpha_comp =  AAcomposition(sequencesTMH)
alpha_comp['class'] = 'alpha'
beta_comp = AAcomposition(sequencesTMB)
beta_comp['class'] = 'beta'

data_total = pd.concat((alpha_comp, beta_comp), axis=0, ignore_index = True)
data_test = data_total.sample(frac= test_split)
data_train = data_total[~data_total.index.isin(data_test.index)]

composition2arff(data_train, 'aplhabeta_train.arff')
composition2arff(data_test, 'alphabeta_test.arff')

#%%
