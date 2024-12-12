# Campaign Spending in the 2024 US Presidential Election

------------------------------------------------------------------------

## Introduction

During the 2024 United States Presidential Election campaign, much public interest developed regarding the spending each campaign undertook. Of particular interest are both the magnitude and the types of spending in which each campaign engaged.

To help the public further understand the specifics of this spending, a dashboard presenting the detailed expenditures by the campaigns for the final two candidates (Kamala Harris and Donald Trump) is presented. To allow user-driven investigation of the data, filters are offered to allow refinement of the visualization by candidate, time frame, and spending categories.

## Data Used

The Federal Election Commission (FEC) is the independent regulatory agency charged with administering and enforcing the federal campaign finance law. The FEC has jurisdiction over the financing of campaigns for the U.S. House, Senate, Presidency and the Vice Presidency. [^instructions-1]

[^instructions-1]: <https://www.fec.gov/about/mission-and-history/>

As part of the FEC's mission, it captures and reports financial transactions related to the US Presidential Election campaigns, inclusive of both fundraising and expenditures (herein referred to as disbursements). This is the sole source of data for this analysis.

### Source

The data in this under study is from the US Federal Election Commission, [retrieved](https://www.fec.gov/data/disbursements/?data_type=processed&committee_id=C00694455&committee_id=C00703975&committee_id=C00828541&committee_id=C00867275&two_year_transaction_period=2024) 17-Nov-2024 at 2103 CST. Due to the notable change of candidates midway through 2024, it should be noted that expenditures aligned to the Harris campaign prior to July were in support of President Biden’s campaign. These are attributed here to Harris as they can be considered supportive of all Democratic nominees in pursuit of office for that campaign.

### Population

The data used includes disbursements for the election committees identified, during the calendar year 2024. Within the context of the FEC data, a *committee*, "encompasses several different political groups that receive and spend money in federal elections." [^instructions-2]

[^instructions-2]: <https://www.fec.gov/data/browse-data/?tab=committees>

For Kamala Harris' campaign, the FEC identifies committees C00703975, and C00694455 [^instructions-3] as allocated to her pursuit of office. Likewise, committees C00828541 and C00867275 [^instructions-4] are attributed to Donald Trump's campaign efforts. As part of the initial data load and preparation, these committees are re-categorized to a single factor representing each candidate.

[^instructions-3]: <https://www.fec.gov/data/candidate/P00009423/?cycle=2024&election_full=true>
[^instructions-4]: <https://www.fec.gov/data/candidate/P80001571/?cycle=2024&election_full=true>

In the interest of transparency, it is noted that transactions prior to 01-Jan-2024 and after 17-Oct-2024 have been omitted. This eliminates a very small subset prior to 2024 and a few spurious entries with dates after the source data was generated. These are reasonably assumed to be erroneous.

### Variables

While the source FEC disbursements data offers no less than 78 variables for each transaction, only a few are of interest for this study. The following variables are used for this analysis:

-   **committee_id:** Provided as text (mutated to *candidate* as text). The source data relates a specific transaction to a campaign committee (defined above).
-   **disbursement_date:** Provided as YYYY-MM-DD formatted text (mutated to *disb_date* as type Date). The date of the disbursement transaction.
-   **disbursement_amount:** Provided as text in US dollar currency format (mutated to *amount* as float). The amount of the disbursement
-   **disbursement_purpose_category:** Provided as text (mutated to *category* as a factor). The category of the disbursement transaction

## Motivation

As mentioned above, great public interest developed surrounding how the campaigns invested their war chests in pursuit of the Presidency. The interactive graphic offers free exploration of the data through manipulation of the provided filters. While not exhaustive, some questions that a user might answer through this facility:

-   How much money was spent on each election campaign?
-   Who spent the most money during their campaign?
-   When did the candidates choose to spend the most money? The least?
-   What did they spend the money on? Did the categories change in priority over time?
-   How did President Biden's withdrawal appear to affect spending, if at all?

## Explanation

Through use of the supplied filtering controls, users are able to answer a great variety of questions including and beyond those posed above. The provided visualization readily shows the comparative amounts spent per campaign, per month. The aggregation of spending categories allows easy comparative analysis of monthly spending and the subordinate categorical spending.

-   By adjusting the dates selected, it is possible to analyze the entire set of transactions or to limit the spending down to a specific subset of dates.

-   Selecting any number of spending categories will allow comparison of one or more individual areas of expenditure.

-   Selection of only a single candidate will allow for larger-scale representation of the visualization in that specific case.

## Conclusions

From the visualization, it is evident that Kamala Harris incurred significantly greater expenses overall. While Donald Trump showed more disbursements very early in the year, these did not keep up with the growth in spending on the Democrat side of the campaign.

Both campaigns spent the greatest amounts on advertising, but this was closely followed by the vague category of other expenses. This could present an opportunity for further study.

President Biden's withdrawal from the race in late July did not appear to materially impact the pace of spending growth for either campaign.

Ultimately, it is most notable the vast amount of resources that are spent in the endeavors to secure the Oval Office.

## Citations
