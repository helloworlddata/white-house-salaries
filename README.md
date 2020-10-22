# White House Salaries

----------------

### Deprecation note

This repo has been deprecated and archived as of 2020-10-22.

Find the new repo with new data at: https://github.com/storydrivendatasets/white_house_salaries



-----------------

tl;dr: White House salaries for all staffers, from 2009 to the just-released 2017 list, compiled in one file:

[data/compiled/white-house-salaries.csv](data/compiled/white-house-salaries.csv)

Warning: File has not been double-checked or even spot-checked for errors (2017-06-30)


-------

Today, the Trump administration published White House Staff Salary data at the following URL:

https://www.whitehouse.gov/staff-salaries

Currently, the data exists only as PDF:

https://www.whitehouse.gov/sites/whitehouse.gov/files/docs/disclosures/07012017-report-final.pdf 

For comparison's sake, President Obama's White House salary data was released as machine-readable CSV, for the years 2009 through 2016:

https://obamawhitehouse.archives.gov/briefing-room/disclosures/annual-records/2016


## Inventory

The [data/raw](data/raw) directory contains CSVs from the Obama administration:

- [data/raw/2009.csv](data/raw/2009.csv)
- [data/raw/2010.csv](data/raw/2010.csv)
- [data/raw/2011.csv](data/raw/2011.csv)
- [data/raw/2012.csv](data/raw/2012.csv)
- [data/raw/2013.csv](data/raw/2013.csv)
- [data/raw/2014.csv](data/raw/2014.csv)
- [data/raw/2015.csv](data/raw/2015.csv)
- [data/raw/2016.csv](data/raw/2016.csv)
- (TODO) Use csvkit's csvstack to create one large file

From the 2017 release:

- The raw PDF: [data/raw/2017.pdf](data/raw/2017.pdf)
- ABBYY's conversion of that PDF to XLSX (one file for each sheet): [data/raw/2017-abbyy-to-xlsx/](data/raw/2017-abbyy-to-xlsx/)
- (TODO) Using **in2csv** and other csvkit tools to compile those Excel spreadsheets into one plaintext CSV.




### Fetching


Quickie shell commands to download the files and save them to `data/raw`


```sh
mkdir -p data/raw

curl -Lo data/raw/2017.pdf \
  https://www.whitehouse.gov/sites/whitehouse.gov/files/docs/disclosures/07012017-report-final.pdf

curl -Lo data/raw/2016.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2016_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2015.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2015_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2014.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2014_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2013.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2013_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2012.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2012_Annual_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2011.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2011_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2010.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2010_Report_to_Congress_on_White_House_Staff.csv

curl -Lo data/raw/2009.csv \
  https://open.obamawhitehouse.archives.gov/sites/default/files/2009_Report_to_Congress_on_White_House_Staff.csv
```


### Converting

Note: the PDF to XLS step was done by ABBYY, i.e. not programmatic.

The [wrangle/xls_to_pdf.py](wrangle/xls_to_pdf.py) command-line script is given a path to a bunch of XLS files (e.g. [data/raw/2017-abbyy-to-xlsx](data/raw/2017-abbyy-to-xlsx)) and compiles them into a single CSV file:

[data/converted/2017.csv](data/converted/2017.csv)


### Compiling

Use [wrangle/compile.py](wrangle/compile.py) to read all the CSV files, add a year column, and compile them to the final file:

[data/compiled/white-house-salaries.csv](data/compiled/white-house-salaries.csv)
```sh
$ python wrangle/compile.py \
  data/raw/*.csv data/converted/2017.csv \
  > data/compiled/white-house-salaries.csv
```


