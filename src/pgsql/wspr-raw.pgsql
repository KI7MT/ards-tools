-- *****************************************************************************
-- WARNING: Use At Your Own Risk. Creates a Table that is >= 153 GB!
--
-- NOTE: Two files in 2010, and one in 2018 have syntax issues. They are easily
--       fixed with search and replace | delete, but, the errors will stop this
--       script from running until resolved.
--
-- *****************************************************************************

\set name wspr
\set ver 0.0.1
\set adifv 0.0.0

\! clear

\echo ''
\echo '-------------------------------------------------'
\echo 'Importing CSV Files (be patient it takes a while)'
\echo '-------------------------------------------------'
\echo ''

-- 2008 CSV files
\echo 'Processing Year 2008'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2008-12.csv' DELIMITER ',' CSV HEADER;

-- 2009 CSV files
\echo ''
\echo 'Processing Year 2009'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2009-12.csv' DELIMITER ',' CSV HEADER;

-- 2010 CSV files
\echo ''
\echo 'Processing Year 2010'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2010-12.csv' DELIMITER ',' CSV HEADER;

-- 2010 CSV files
\echo ''
\echo 'Processing Year 2011'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2011-12.csv' DELIMITER ',' CSV HEADER;

-- 2012 CSV files
\echo ''
\echo 'Processing Year 2012'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2012-12.csv' DELIMITER ',' CSV HEADER;

2013 CSV files
\echo ''
\echo 'Processing Year 2013'
-- \COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2013-12.csv' DELIMITER ',' CSV HEADER;

-- 2014 CSV files
\echo ''
\echo 'Processing Year 2014'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2014-12.csv' DELIMITER ',' CSV HEADER;

-- 2015 CSV files
\echo ''
\echo 'Processing Year 2015'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2015-12.csv' DELIMITER ',' CSV HEADER;

-- 2016 CSV files
\echo ''
\echo 'Processing Year 2016'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2016-12.csv' DELIMITER ',' CSV HEADER;

-- 2017 CSV files
\echo ''
\echo 'Processing Year 2017'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2017-12.csv' DELIMITER ',' CSV HEADER;

-- 2018 CSV files
\echo ''
\echo 'Processing Year 2018'
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-01.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-02.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-03.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-04.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-05.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-06.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-07.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-08.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-09.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-10.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-11.csv' DELIMITER ',' CSV HEADER;
\COPY wspr.raw_csv FROM PROGRAM 'cat wspr/wsprspots-2018-12.csv' DELIMITER ',' CSV HEADER;

-- END: wspr-raw.sql