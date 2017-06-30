# Command-line script to read XLS files
# and convert them to plain text CSV

from argparse import ArgumentParser
from csv import DictWriter, DictReader
from glob import glob
from os.path import isdir, join as joinpath
from sys import stdout
from xlrd import open_workbook


HEADERS_TEXT = 'NAME,STATUS,SALARY,PAY BASIS,POSITION TITLE'
HEADERS = HEADERS_TEXT.split(',')

def process_wh_salary_workbook(wbpath):
    """
    a very non-generalized function, expecting things to
    be in the expected WH salary format, headers and all,
    single sheet. No need to make it more flexible right now.
    """
    book = open_workbook(wbpath)
    sheet = book.sheets()[0]
    headers_found = False
    for n in range(sheet.nrows):
        cols = sheet.row_values(n)
        if not headers_found:
            if cols == HEADERS:
                headers_found = True
        else:
            # headers have been found
            # don't capture anything if unless
            # all cells are filled...
            if all(c for c in cols) and len(cols) == len(HEADERS):
                yield dict(zip(HEADERS, cols))



if __name__ == '__main__':
    parser = ArgumentParser("Convert WH salary XLS page(s) to CSV")
    parser.add_argument('inpath', type=str, help="Path to a XLSX file, or directory of them")
    args = parser.parse_args()
    inpath = args.inpath
    if isdir(inpath):
        filenames = glob(joinpath(inpath, '*.xls?'))
    else:
        filenames = [inpath]

    # set up the CSV
    csvout = DictWriter(stdout, fieldnames=HEADERS)
    csvout.writeheader()

    for fname in filenames:
        for d in process_wh_salary_workbook(fname):
            csvout.writerow(d)


