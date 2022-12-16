# Investigating the potential of a synergistic use of Sentinel-1 and Sentinel-2 to classify and map a Northern-German saltmarsh

As part of an internship in the OSIRS research group at NESRC, the supervisor Antonio Bonaduce suggested a short project inspired by the study Mapping Atmospheric Exposure of the Intertidal Zone with Sentinel-1 CSAR in Northern Norway of Jörg Haarpaintner and Corine Davids, 2021. Haarpaintner & Davids classified and mapped intertidal zones of Norway using optical and SAR satellite imagery from the Sentinel missions 1 and 2. Since the masterthesis of me evolved around an inter-tidal ecosystem at the north-western coast of Germany in the nationalpark Wadden Sea, the saltmarsh Hamburger Hallig, this study area was chosen for testing and reproducing the methodological approach. During the course of the internship, it became clear that the exact same methodology as proposed could not be applied and an own classifier was developed. Instead, the focus shifted towards a binary classification of saltmarsh-non saltmarsh pixels based on input data derived from the respective satellite products. The chosen classification method Random Forest belongs to decision tree based machine learning techniques and is trained with labelled input data. The trained classifier is later applied to new input data. The end project therefore aims at investigating the use of synergistic data combinations, namely optical Sentinel-2 data, spectral indices and backscatter values of Sentinel-1, to classify and map saltmarshes.

## Workflow

### Overview
The project was divided into three main parts:
  1. Pre-processing the input data
  2. Training the classifier with different source of input data
  3. Re-applying the trained classifier to new dates for the study year 2021

### Preparation and general remarks

To have a Linux-style environment and have no trouble anymore with broken path permissions and weirdly installed Python packages and co-dependencies, Artyom Moiseev set up a container to work in.

### Pre-processing the input data

The Sentinel-2 data and the spectral indices were already calculated for my master thesis, so I could re-use them for this project. AWEI and NDWI were calculated additionally. The indices are namely: AWEI, EVI, NDMI, NDVI, NDWI, MSAVI & SAVI. 
The study site Hamburger Hallig lies north of Husum and is close to the Northern Sea islands Föhr, Amrun and Pellworm and the half-island Nordstrand. The study site is characterized by a mild temperate climate, with a mean temperature in July of 16°C and in January of 0.5-1°C (Suchrow and Jensen, 2010). The precipitation maximum lies in autumn and has an annual mean of 700-750 millimeters (mm) (Suchrow and Jensen, 2010). The study site has a tidal range of 3.4 meters with mean high tide lying at around 1.6 meters above Normal Height Zero (NHN) and an elevation between 0.9 and 2.6 meters (m) NHN (Mueller et al., 2019). Due to the high tidal differences in the study area, on average around 3 meters, colocation of Sentinel-2 and Sentinel-1 data was very difficult.
The respective Sentinel-1 product on 16.07.2021 (UTC: 05:40) would have a tidal height of 622 cm and was therefore not included in the stack to keep the tidal state as close to the original Sentinel-2 state as possible. As pre-processing, the Sentinel-1 data was reprojected to the Sentinel-2 domain.
As the chosen classifier, Random Forest, needs labeled input data, class labels were created manually based on vector data provided by the LKN.SH, saltmarsh patches mapped by Dr. Florian Uhl, University of Kiel, and visual interpretation of the Sentinel-2 bands in QGIS. Since the objective of the project was slightly different initially, six classes were labeled: water (1), seabed (2), structures (3), pioneer saltmarsh zone (4), lower saltmarsh zone (5), upper saltmarsh (6). The saltmarsh classes were then later merged to one, as well as classes 1-3 into one, creating a binary classification of saltmarsh/ no saltmarsh. The adjacent agricultural terrestrial areas were influencing the quality of the classification due to the patchiness of the different crops, therefore this area outside the tidal area was masked out for classification with an AOI mask created in QGIS. 

### Training the classifier with different source of input data and re-applying to new dates

The classifier was trained with input data from July (Sentinel-1: 07.07.2021; Sentinel-2: 16.07.2021). The labeled and masked image can be found in the folder /figures. As one step further, the pixel values for the labels were extracted from the raster data and were split into training data (70% of all labels) and test data (30%) for the Random Forest classifier. The classifier model was then fitted to the data and could then be assessed for accuracy through confusion matrices or accuracy scores.
To build up for the classification and assess the respective problems, the input data was first split into three categories (Sentinel-1, Sentinel-2, Indices) to account for the training data of the classifier. Since the focus was on Sentinel-1 data in this classification, because very few studies use explicitly only SAR to classify and I had not worked with SAR data before, time series were created only from this input source. Finally, all the input data was combined in one data stack and used for a classification. All the classified pictures can be found in the folder /figures.

### Structure

The classification was done in the *nicely_combined_classification* file. This is the most important file.
Results were plotted in the *plotting_results* file. 
The *looking at statistics* file was to explore mainly the time series value distribution of the VV and VH backscatter values, but also to plot a RGB-True Colour image of the Sentinel-2 data and the spectral indices.
Since I had no prior knowledge of Python, I was trying around a bit in the *tries with nansat and index plotting* file.

## Literature

 - Esselink, P., van Duin, W.E., Bunje, J., Cremer, J., Folmer, E.O., Frikke, J., Glahn, M., Groot, A.V. de, Hecker, N., Hellwig, U., Jensen, K., Körber, P., Petersen, J., & Stock, M. (2017). Salt marshes. Wadden Sea Quality Status Report 2017. qsr.waddensea-worldheritage.org/reports/salt-marshes.
 - Haarpaintner, J. & Davids, C. (2021). Mapping Atmospheric Exposure of the Intertidal Zone with Sentinel-1 CSAR in Northern Norway. Remote Sensing, 13, 3354.
 - Lovelock, C.E., & Reef, R. (2020). Variable Impacts of Climate Change on Blue Carbon. One Earth, 3, 195–211.
 - Macreadie, P.I., Anton, A., Raven, J.A., Beaumont, N., Connolly, R.M., Friess, D.A., Kelleway, J.J., Kennedy, H., Kuwae, T., Lavery, P.S., Lovelock, C.E., Smale, D.A., Apostolaki, E.T., Atwood, T.B., Baldock, J., Bianchi, T.S., Chmura, G.L., Eyre, B.D., Fourqurean, J.W., Hall-Spencer, J.M., Huxham, M., Hendriks, I.E., Krause-Jensen, D., Laffoley, D., Luisetti, T., Marbà, N., Masque, P., McGlathery, K.J., Megonigal, J.P., Murdiyarso, D., Russell, B.D., Santos, R., Serrano, O., Silliman, B.R., Watanabe, K., & Duarte, C.M. (2019). The future of Blue Carbon science. Nature communications, 10, 3998.
 - Mueller, P., Ladiges, N., Jack, A., Schmiedl, G., Kutzbach, L., Jensen, K., & Nolte, S. (2019b). Assessing the long‐term carbon‐sequestration potential of the semi‐natural salt marshes in the European Wadden Sea. Ecosphere, 10, 1.
 - Mudd, S.M., Howell, S.M., & Morris, J.T. (2009). Impact of dynamic feedbacks between sedimentation, sea-level rise, and biomass production on near-surface marsh stratigraphy and carbon accumulation. Estuarine, Coastal and Shelf Science, 82, 377–389.
 - Ouyang, X., & Lee, S.Y. (2013). Carbon accumulation rates in salt marsh sediments suggest high carbon storage capacity.
 - Siikamäki, J., Sanchirico, J.N., Jardine, S., McLaughlin, D., & Morris, D. (2013). Blue Carbon. Coastal Ecosystems, Their Carbon Storage, and Potential for Reducing Emissions. Environment: Science and Policy for Sustainable Development, 55, 14–29.
 - Suchrow, S., & Jensen, K. (2010). Plant Species Responses to an Elevational Gradient in German North Sea Salt Marshes. Wetlands, 30, 735–746.
