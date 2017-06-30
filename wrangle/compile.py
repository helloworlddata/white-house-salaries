"""
compile.py

Use to collate raw/*.csv and converted/2017.csv into one happy file
adds year column, based on filename
assumes all files have the same format and column arrangement, even if
  header names are different
"""

from os.path import join as joinpath, basename
from argparse import ArgumentParser
import csv
from sys import stdout
from re import match as rxmatch

HEADERS = ['year', 'employee_name', 'status', 'salary', 'pay_basis', 'position']



if __name__ == '__main__':
    parser = ArgumentParser("Compile CSV files with years as names (e.g. 2017.csv)")
    parser.add_argument('paths', type=str, nargs="+", help="Path CSV files with a year as name")
    args = parser.parse_args()
    filenames = args.paths
    # check to see if filenames have a proper year in them

    if not all(rxmatch(r'^\d{4}\.csv$', basename(fn)) for fn in filenames):
        raise InputError("Not all filenames are in YYYY.csv format: %s" % '\n'.join(filenames))


    # set up the CSV
    csvout = csv.writer(stdout)
    csvout.writerow(HEADERS)

    for fname in filenames:
        year = basename(fname)[0:4]
        with open(fname, 'r') as rf:
            csvin = csv.reader(rf)
            next(csvin) # skip header
            for row in csvin:
                csvout.writerow([year] + row)



