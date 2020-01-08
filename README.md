# PP-MTurk-AAAI2020

This github repository provides a brief summary of the paper [The Effectiveness of Peer Prediction in Long-Term Forecasting](http://www.columbia.edu/~dm3557/papers/mrp20.pdf) and contains the datasets used in the paper.

## Experimental Workflow

The experiment was run on Amazon Mechanical Turk (MTurk) and consisted of two HITs -- a *recruitment* HIT and a *forecasting* HIT, where the recruited workers participated in the actual study. The forecasting HIT was posted on October 7 and was online till October 13. Out of all the recruited workers, we considered about 900 workers who were present for the entire forecasting HIT. The workers were randomly assigned to one of the following four treatments. See the main paper for details about
the treatments.

1. **Scoring Rule** (SR)
2. **Peer Prediction** (PP)
3. **Scoring Rule + Peer Prediction (Rank)** (SR+PPRank)
4. **Scoring Rule + Peer Prediction** (SR+PP)

<p align="center">
<img src="./images/workflow.png" width=600>
</p>

The figure above shows the details of the experiment. We asked the workers to provide forecasts on 18 different questions. There were three different categories of questions: (a) Sports, (b) Politics and Economy and (c) En-tertainment, with six questions from each category. The supplementary material includes the questions along with their outcomes.

## Findings

We find that peer-prediction incentives, whether in monetary or in non-monetary form such as rank, significantly improve engagement with the forecasting platform compared to basic, scoring rule based incentives. Furthermore, we used various aggregators to evaluate the accuracy of aggregated forecasts under different treatments, and found that treatments SR and SR+PPRank, perform best for both dynamic and easy questions, and signifcantly outperform the other treatments for some aggregators. The reader is encouraged to check out the main paper for further details of the analysis. 

## Description of the Dataset

* Folder [./data/](https://github.com/debmandal/PP-MTurk-AAAI2020/tree/master/data) contains three types of files.
    * workers.csv contains the ids of the Turkers who were present for the entire forcasting HIT.
    * answers-octn.csv contains the forecasts submitted to the platform until the end of the n-th day.
    * ppscoren.csv contains the peer prediction scores computed at the end of the n-th day. We converted these scores to actual payments and also to non-monetary feedback. 
* Folder [./src](https://github.com/debmandal/PP-MTurk-AAAI2020/tree/master/src) contains two script files.
    * ppscore.csv computes the peer prediction scores. This file also includes the scoring matrix used to determine the peer prediction scores.
    * analysis.Rmd is a R markdown file and contains many utilities for data wrangling and plots for various statistics like accuracy, returns, changes in forecasts etc.

## How to Cite Our Work

If you use our dataset for further research, please cite our paper as:
- **The Effectiveness of Peer Prediction in Long-Term Forecasting**, Debmalya Mandal, David C. Parkes, and Goran Radanovic, *In Proceedings of the Thirty-Fourth AAAI Conference on Artificial Intelligence* (AAAI-2020).


