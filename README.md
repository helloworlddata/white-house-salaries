# White House Salaries


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


Quickie script to get everything:


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
