# Investigating the potential of a synergistic use of Sentinel-1 and Sentinel-2 to classify and map a Northern-German saltmarsh

As part of an internship at NESRC, the supervisor Antonio Bonaduce suggested a short project inspired by the study Mapping Atmospheric Exposure of the Intertidal Zone with Sentinel-1 CSAR in Northern Norway of Jörg Haarpaintner and Corine Davids, 2021. Haarpaintner & Davids classified and mapped intertidal zones of Norway using optical and SAR satellite imagery from the Sentinel missions 1 and 2. Due to prior knowledge of an inter-tidal ecosystem at the north-western coast of Germany in the nationalpark Wadden Sea, the saltmarsh Hamburger Hallig, this study area was chosen for the test and reproduction of the methodological approach. During the course of the internship, it became clear that the exact same methodology as proposed could not be applied and an own classifier was developed. Instead, the focus shifted towards a binary classification of saltmarsh-non saltmarsh pixels based on input data derived from the respective satellite products. The chosen classification method Random Forest belongs to decision tree based machine learning techniques and is trained with labelled input data. The trained classifier is later applied to new input data. The end project therefore aims at investigating the use of synergistic data combinations, namely optical Sentinel-2 data, spectral indices and backscatter values of Sentinel-1, to classify and map saltmarshes.

# Workflow

## Overview
The project was divided into three main parts:
  1. Pre-processing the input data
  2. Training the classifier with different source of input data
  3. Re-applying the trained classifier to new dates for the study year 2021

