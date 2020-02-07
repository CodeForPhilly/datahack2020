# 2020 Opioid Data Hackathon

> 📢: See this page with a table of contents at https://codeforphilly.github.io/datahack2020/

## Description

[Code for Philly](https://codeforphilly.org/), [DataPhilly](https://www.meetup.com/DataPhilly/), [R Ladies Philly](https://www.rladiesphilly.org/), the [Philly Data Jawn](https://www.phillydatajawn.com/), [Health Federation of Philadelphia](http://www.healthfederation.org), [Prevention Point](http://www.ppponline.org), the [City of Philadelphia](https://www.phila.gov/programs/combating-the-opioid-epidemic/) are hosting a data science hackathon to answer pertinent questions around the Opioid Crisis in Philadelphia. The goals of this event are to provide health organizations with insights that may normally be unavailable to them and to create analyses that help inform the public about the opioid epidemic in our city.

## Partner Organizations

- [Prevention Point](http://www.ppponline.org) works to improve access to and quality of health and human services for underserved and vulnerable populations
- [Health Federation of Philadelphia](http://www.healthfederation.org) works to improve access to and quality of health and human services for underserved and vulnerable populations
- the City of Philadelphia

## Research Questions

Hackathon planners have been working with our partners to identify and clean relevant datasets that would be helpful in answering these broader questions:

1. Can we visualize the recovery process with regards to building understanding in the general public and better tools for warm handoffs?
2. What have been the effects of citizens’ access to Narcan?
3. Can we estimate the population of individuals using IV drugs in Philadelphia?
4. Data exploration

## [Timeline and Workflow](https://codeforphilly.org/events/datahack2020)

**Feb 7, 2020 (Friday): [Partner presentation night](https://www.meetup.com/Code-for-Philly/events/267524879/)**
    - Hack participants will have the opportunity to hear directly from partner organizations about the challenges they face and what analyses would be most useful to them. After the talks, participants will be encouraged to sign up to a team via [this Google Doc](https://docs.google.com/document/d/1ztiCetudsQuIAHyyYVHKnBeqI1gsde_l1SvRk2V65bw/edit?usp=sharing). 

**Feb 8, 2020 (Saturday): [First hack day](https://www.meetup.com/Code-for-Philly/events/267544650/)**
    - No formal presentations scheduled on this day. Upon arriving, participants will be encouraged to [sign up to a team](https://docs.google.com/document/d/1ztiCetudsQuIAHyyYVHKnBeqI1gsde_l1SvRk2V65bw/edit?usp=sharing) if they have not already done so the previous evening. Teams will then get together to discuss ideas for research questions to pursue, and work out any team logistics (including selecting a team leader, frequency of meetings, location of meetings, tools to be used, and roles in the team). Space will be available for teams to get started on exploring the data and familiarize themselves with the research topics and tools. 
    
**Every Tuesday, Feb 11 - March 10, 2020: [Hack Nights](https://www.meetup.com/Code-for-Philly/events/)** 
    - Space and pizza will be provided for participants to get together in person and work on the project. There is no attendance requirement, but everyone is welcome. Teams are also welcome to get together at other locations and at other times, but will need to organize these meetings themselves. Teams are also welcome to consider remote work options. 

**March 3, 2020: Wrap up analyses and start writing up report and presentation**
    - By this point, teams should be concluding their analyses and should begin drafting their reports for partners. Teams should expect going through several iterations of these reports, and should therefore allow ample time before the final presentation night to make edits, tweaks and corrections. 

**March 17, 2020 (Tuesday): [Presentation night](https://www.meetup.com/Code-for-Philly/events/268353058/)**
    - Teams will present their findings in front of their fellow hack participants, partner representatives and other data enthusiasts from the general public. Teams should decide on their own the presenter responsibilities, but all presentations are expected to be no longer than 7 minutes long and follow a predefined structure. Teams will have the option to make minor changes to their reports based on discussion at this event.
    
**March 24, 2020**: Final reports due on GitHub. 

## Final Report Structure

Each team is expected to submit a final report, that will follow the structure below ([view an example](https://github.com/rladiesPHL/2019_datathon/blob/master/Analyses/2019_RladiesDatathon_FinalReport.pdf)): 

#### Executive Summary
*This section should have up to 5 bullet points summarizing the main conclusions from the analysis. These should be worded in such a way that stakeholders without data expertise can easily understand what actios would be beneficial. It can be a shorter version of the conclusions section below.*

#### Contributors

*This section should list the names and 1-2 sentence descriptions of everyone who worked on the submission. E.g. "Party Parrot is a data scientist with Philly's DataForGood nonprofit, and a student of applied statistics at Drexel. In both roles, she enjoys conducting predictive analyses and natural language processing.*
#### Problem definition and dataset

*This section should summarize the question your group has worked on, as well as any working definitions that you used (beyond what was outlined in the general description). Additionally, this section should contain any issues or challenges that you noticed in the data, that may be relevant.*

#### Results

*You may structure this section in any way that makes results easier to understand and describe.*

#### Conclusions and Next Steps

*This section should have a bulletpoint list of what conclusions can be drawn from the analyses that were performed, and what next steps should be taken*


## Data

### Datasets and Codebooks

> 📢: Visit the [codebooks section](https://github.com/CodeForPhilly/datahack2020/tree/master/codebooks) for a detailed list of database data.

Other userful data sources:

- [Census.gov: State Population Totals and Components of Change: 2010-2018](https://www.census.gov/data/datasets/time-series/demo/popest/2010s-state-total.html#par_textimage_1873399417)
- [PA.gov: Overdose Information Network Data CY January 2018 - Current Monthly County State Police](https://data.pa.gov/Opioid-Related/Overdose-Information-Network-Data-CY-January-2018-/hbkk-dwy3)
- [CDC: Opioid Data Analysis and Resources](https://www.cdc.gov/drugoverdose/data/analysis.html)

### Access the data in R

First, log into Code for Philly Slack and join channel #data-hack-chat -> database username and password are a pinned topic in there

#### Option 1: 

- [Install RStudio](https://rstudio.com/products/rstudio/download/)
- New Project -> Version Control -> Git -> Repository URL: https://github.com/CodeForPhilly/datahack2020.git (make sure you choose your preferred project directory, and then click "Create Project")
- Set 2 system variables to allow access to the database; type this in the Console: 

    ```
    Sys.setenv(DATAHACK_DB_USER = "reader") 
    Sys.setenv(DATAHACK_DB_PASS = "[pwd]") # replace [pwd] with the the password you got from the Slack channel

    ```
- Run the script /home/connect_to_db_rstudio.R; if you get authentication errors, set the environment variables again via the code above. 

#### Option 2: Rocker

- [Install Docker](https://docs.docker.com/install/)
- Via Docker Quickstart Terminal, cd to ~/datahack2020/docker
- Run: 

```
docker-compose up
```
- When that is done processing, open a browser and go to: 192.168.99.100:8787 (on Windows) or localhost:8787 (on Mac) (if this doesn't work, open up another Docker Quistart Terminal and see what IP is listed there; use that IP address instead of 192.168.99.100)
- When the Rstudio in your browser asks for credentials: username = rstudio, password = datahack
- Run the 2 Sys.setenv commands from above
- Run the script /home/connect_to_db_rstudio.Rmd

### Access the data in Python

#### Option 2: Rocker

Here is a [2 minute screencast of this approach, with unfortunately no sound](https://v.usetapes.com/GlsLP4I8LB).

- [Install Docker](https://docs.docker.com/install/)
- Via Docker Quickstart Terminal, cd to ~/datahack2020/docker
- Run: 
```
docker-compose up
```
- When that is done processing, open a browser and go to: 192.168.99.100:8999 (on Windows) or localhost:8999 (on Mac) (if this doesn't work, open up another Docker Quistart Terminal and see what IP is listed there; use that IP address instead of 192.168.99.100)
- Open the file `_env` and set your credentials. Rename it to `.env`
- Run the notebook `/home/test_notebook.ipynb`



https://v.usetapes.com/GlsLP4I8LB
    
## Collaborating using Git: Guidelines

- For those that don't yet have Git installed on their machines, follow [this link](https://gist.github.com/derhuerst/1b15ff4652a867391f03) for installation
- For those that are R users and are new to Git and GitHub, we recommend [this resource](https://happygitwithr.com) as well as these instructions from [a past datathon](https://docs.google.com/document/d/1m0dXQvt7U4bR6Zie3VlwKv25idZW-MbiLxJV2uG9q7I/edit?usp=sharing)
- For any contributions, please only work/modify within the analyses/ directory specific to the group you are contributing to. In other words, don’t add files to places other than analyses, unless you ask first. This is meant to help avoid unnecessary conflicts.

To contribute, you will need to:

- Fork the repo (required)
- Create a new branch in your forked repo (branch names should have descriptive names and should end with your initials, eg. if Party Parrot is in Team 2 and is working on a network analysis, she would create a branch under the folder /analyses/team02 and call it "team02_network_analysis_pp")
- Clone the repo to your machine
- Do work in your branch
- When ready, commit and push all your changes to the fork (or your team's fork if you're all working off of one fork) in GitHub
- When ready, make a pull request to the Code for Philly repo (this will notify admins to review your pull request before merging it into master); NOTE: when making a pull request to the Code for Philly repo, you MUST include your team name, either in the branch of origin, the pull request title or description; if we can't easily figure out which team the pull request belongs to, we will have to send it back for this info to be added (this will allow us to more easily make sure teams only push work to their team's folder)

## Additional information

### Past opioid analyses

Below are a few links to help you better understand some analyses and work that has already been done in this area. These links are for informational purposes only. 

- [Exploring the Economic Effects of the Opioid Epidemic](https://www.philadelphiafed.org/-/media/research-and-data/publications/economic-insights/2019/q2/eiq219-opioid-impact.pdf?la=en)
- [Combating the opioid epidemic](https://www.phila.gov/programs/combating-the-opioid-epidemic/reports-and-data/opioid-misuse-and-overdose-data/)

## Code of Conduct

The organizing groups are dedicated to creating a hackathon that reflects the diversity of the City of Philadelphia, and to providing a friendly, safe, welcoming, and harrassment-free environment for everyone, regardless of gender, sexual orientation, mental and/or physical ability, ethnicity, socioeconomic status, age, and religion (or lack thereof). This code of conduct outlines our expectations for all those who participate in this hackathon, as well as consequences for unacceptable behavior that contributes to making anyone feel unsafe or unwelcome in our community. Anyone who violates this code of conduct may be sanctioned or expelled from the hackathon at the discretion of the leadership team. Participants are responsible for knowing and abiding by these rules.

We expect all participants (contributors, paid or otherwise; sponsors; and other guests) to abide by this Code of Conduct in all venues–online and in-person–as well as in all one-on-one communications pertaining to community business. This code of conduct and its related procedures also applies to unacceptable behavior occurring outside the scope of community activities when such behavior has the potential to adversely affect the safety and well-being of community members.

This Code of Conduct was adapted for the hackathon from the [Code for Philly Code of Conduct](https://codeforphilly.org/pages/code_of_conduct/) and the [R-Ladies Code of Conduct](https://rladies.org/code-of-conduct/).

### 1. Expected Behavior

The following behaviors are expected and requested of all hackathon participants:

- Participate in an authentic and active way. 
- Exercise consideration and respect in your speech and actions.
- Attempt collaboration before conflict.
- Refrain from demeaning, discriminatory, or harassing behavior and speech. For more details and examples, see section 5.
- Help us maintain an environment that encourages social entrepreneurship and civic mindedness.
- Do not assume someone has a specific skill, experience, or education or judge them based on a perceived lack in any of those areas. Instead, help us inspire productivity in our fellow community members regardless of specific skill.
- Refrain from policing community membership based on location. We define “Philly” broadly to include those who live, work, or visit Philadelphia as well as the towns and suburbs neighboring the city.
- Be mindful of your surroundings and of your fellow participants. Alert community leaders if you notice a dangerous situation, someone in distress, or violations of this Code of Conduct, even if they seem inconsequential.
- Remember that community event venues may be shared with members of the public; please be respectful to all patrons of these locations.

### 2. Unacceptable Behavior

The following behaviors are considered harassment and are unacceptable among participants of this hackathon:

- Violence, threats of violence or violent language directed against another person, including incitement of violence towards any individual (e.g. including encouraging a person to commit suicide or to engage in self-harm).
- Offensive comments related to gender, gender identity and expression, sexual orientation, disability, mental illness, neuro(a)typicality, physical appearance, body size, age, race, ethnicity, or religion.
- Unwelcome comments regarding a person’s lifestyle choices and practices, including those related to food, health, parenting, drugs, and employment.
- Deliberate misgendering or use of ‘dead’ or rejected names.
- Posting or displaying sexually explicit or violent material.
- Posting or threatening to post other people’s personally identifying information (“doxing”).
- Inappropriate or non-consensual photography or recording, including logging online activity for harassment purposes.
- Physical contact and simulated physical contact (eg, textual descriptions like “hug” or “backrub“) without consent (you need to have someone’s consent before touching them) or after a request to stop. 
- Unwelcome sexual attention. This includes, sexualized comments or jokes; inappropriate touching, groping, and unwelcome sexual advances.
- Deliberate intimidation, stalking or following (online or in person).
- Deliberate silencing of other community members in the form of constant interruption, undermining the thoughts and opinions of others, or otherwise perpetuating demeaning commentary
- Advocating for, encouraging, or any form of tolerating any of the above behavior.
- Sustained disruption of community events, including talks and presentations.
- Pattern of inappropriate social contact, such as requesting/assuming inappropriate levels of intimacy with others.
- Continued one-on-one communication after requests to cease.
- Deliberate “outing” of any aspect of a person’s identity without their consent except as necessary to protect vulnerable people from intentional abuse.
- Publication of non-harassing private communication.

### 3. Reporting

If you are being harassed by another participant, notice that someone else is being harassed, or have any other concerns, please contact the leadership team via safespace@codeforphilly.org. 

Leadership team members are available to help participants engage with local law enforcement or to otherwise help those experiencing unacceptable behavior feel safe. Organizers will also provide escorts as desired by the person experiencing distress.

We will respect confidentiality requests for the purpose of protecting victims of abuse. At our discretion, we may publicly name a person about whom we’ve received harassment complaints, or privately warn third parties about them, if we believe that doing so will increase the safety of our participants or the general public. We will not name harassment victims without their affirmative consent.

### 4. Violation Process

If a participant is found to be in violation of this code of conduct, they will be informed verbally and/or in writing by the leadership team. Participants asked to stop any harassing behavior are expected to comply immediately. If the individual is not an immediate threat to the community, they will be issued a warning. If, after receiving an initial warning, the individual is found to have violated the code of conduct a second time, that individual can be expelled from the hackathon. When expelled, they will not be granted access to in-person events and will be removed from all hackathon-related social media platforms. Consideration will be given at all times to the severity of a given code of conduct violation. If it is in the best interest of the community for an individual to immediately be expelled from the hackathon, it is the discretion of the leadership team to do so.

If you feel you have been falsely or unfairly accused of violating this Code of Conduct, you should notify the leadership team with a concise description of your grievance.

## Leadership Team

Should you need to get in touch with the leadership team, you can reach out to us over Code for Philly Slack:

- Marieke Jackson, Code for Philly (`marieke`)
- Karla Fettich, R Ladies Philly (`karla`)
- Michael Chow, Code for Philly (`machow`)
- Joey Logan, CHOP (`joey_logan`)
- Michael Becker, DataPhilly (`beckerfuffle`)
- Dan Larson, Data Jawn (`dwlarson10`)
