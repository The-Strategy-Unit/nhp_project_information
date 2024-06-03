---
name: Release Checklist
about: Captures all Quality Assurance steps taken when releasing a new version of
  the model, inputs, and outputs apps
title: Release Checklist v.[X.X]
labels: qa
assignees: ''

---

We have three types of releases: major, minor and patch following semantic versioning. Major releases must meet criteria for patch, minor and major. Minor releases must meet criteria for patch and minor.

# Patch

## Data
Patch releases should not involve changes to data.

## Inputs
- [ ] Scenarios can be created from scratch
- [ ] New scenarios can be created from existing
- [ ] Existing scenarios can be edited
- [ ] If text for inputs has been updated, also update project_information

## End-to-end test
Patch releases should not involve changes to end-to-end process.

## Model
- [ ] Model can be run locally on synthetic data

## Outputs
- [ ] Able to load and view results for a model run
- [ ] Click on all tabs and check figures show on all tabs

# Minor
- [ ] 100% test coverage for all repos
- [ ] Update posted on project_information site

## Data
- [ ] Has been copied to Azure into v.X.Y.Z 

## Inputs
- [ ] GH Actions variables updated to vX.Y.Z 
- [ ] New version number added to inputs selection app dropdown 
- [ ] Start model run

## End-to-end test
- [ ] Check model run submitted from inputs app completes and scenario results are viewable on Outputs

## Model
- [ ] GH Actions variables updated to vX.Y.Z 
- [ ] Run at least 2 random scenarios from previous release and check results are similar to previous release.

## Outputs
- [ ] Download reuslts of new model scenario in Excel format

# Major
- [ ] User testing conducted
