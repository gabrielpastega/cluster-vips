<h2>LOYALTY PROGRAM WITH CLUSTERING AND RFM MODEL</h2>
<h2>PROJECT OBJECTIVE</h2>
<p>This project aims to develop a loyalty program using a clustering machine learning algorithm based on RFM (Recency, Frequency, Monetary) features. The objective is to segment customers into 10 distinct groups to tailor targeted marketing strategies, enhance customer engagement, and identify the most valuable customers.</p>
<h2>SOLUTION STRUCTURE</h2>
<p>The project is organized into the following sections:</p>
<ul>
<li><strong>Data Collection:</strong> This project utilizes the following dataset: <a href="https://www.kaggle.com/datasets/carrie1/ecommerce-data">E-Commerce Data</a></li>
<li><strong>EDA:</strong> Includes exploratory data analysis notebooks and profile reports that provide insights into the dataset.</li>
<li><strong>Data Modeling:</strong> This implements the clustering machine learning algorithm and feature engineering of the dataset into the RFM model.</li>
<li><strong>Results Analysis:</strong> Includes analysis and visualization of the results obtained from the clustering algorithm.</li>
<li><strong>Model Deployment:</strong> Documentation and scripts for deploying the trained model in the AWS environment utilizing RDS, S3, and EC2 services.</li>
<li><strong>Next Steps:</strong> Outlines future improvements and enhancements for the algorithm and solution developed.</li>
</ul>
<h2>DATA COLLECTION</h2>
<p>The data for this project can be obtained on the Kaggle website <a href="https://www.kaggle.com/datasets/carrie1/ecommerce-data">(E-Commerce Data</a>) it contains 541909 rows and 9 columns, also it was used the cp437 for decoding the dataset.</p>
<h2>EXPLORATORY DATA ANALYSIS (EDA)</h2>
<p>Initially, an empty column was removed and the remaining columns were renamed for easier manipulation. The dataset has missing data in the customer_id and description features, which was dropped, as it cannot be assumed that each missing customer_id is unique or how it relates to the rest of the features since the project is based on customer behavior.</p>
<p>When examining the numerical attributes, it can be observed that both the quantity and unit price have a wide range, a mean above the median, and a large distance from the 3IQR to the maximum value, indicating the presence of outliers. The unit_price has really small values inferior to 0.01 that will be filtered out, and there are negative quantities, which can be returned products.</p>
<p>On the categorical attributes the 'invoice_no' feature contains data where a letter has been added to the code, and the encoding of this variable and its use is unknown. Additionally, it's noticeable that these data are related to the negative numbers in the 'quantity' numeric feature. The 'stock_code' feature also contains some codes with added letters, and accessing the data source is necessary for a better understanding of them. However, codes consisting of only letters don't seem to represent sales, so they need to be addressed. Within the 'country' feature, there are data entries that are not specified as countries and are not recognized as valid countries.</p>
<p>Before we can start the feature engineering and data modeling we will filter some of the data with the following criteria:</p>
<ol>
<li>Numerical feature 'unit_price' with values above 0.04.</li>
<li>Categorical feature 'stock_code': remove values that are used exclusively in a few cases.</li>
<li>Categorical feature 'description': remove completely.</li>
<li>Categorical feature 'country': remove unspecified and non-country entries.</li>
<li>User 16446 with highly divergent results.</li>
<li>Numerical feature 'quantity' is divided into 2 new data frames.</li>
</ol>
<h2>DATA MODELLING</h2>
<p>For the development of feature engineering, we based our features using RFM (Recency, Frequency, Monetary) model that quantifies and segments customers based on their recent purchasing behavior, frequency of transactions, and monetary value, aiding in targeted marketing strategies. Beyond recency, frequency, and monetary (named gross_revenue in the project) it was also created:</p>
<ol>
<li>
<p><strong>total_orders</strong>: total number of distinct orders placed by customers.</p>
</li>
<li>
<p><strong>total_products_ordered</strong>: cumulative count of unique products ordered by each customer</p>
</li>
<li>
<p><strong>total_quantity</strong>: sum of quantities for all products ordered, indicating the overall volume of items purchased.</p>
</li>
<li>
<p><strong>avg_basket_size_products</strong>: average number of distinct products included in each customer's order.</p>
</li>
<li>
<p><strong>avg_basket_size_quantity</strong>: average quantity of items purchased in each customer's order.</p>
</li>
<li>
<p><strong>avg_ticket</strong>: average monetary value of each order, reflecting the average transaction amount.</p>
</li>
<li>
<p><strong>avg_recency_days</strong>: average time elapsed since the most recent purchase across all customers, indicating recency of activity.</p>
</li>
<li>
<p><strong>qty_returns</strong>: total quantity of items that have been returned by customers, indicating the extent of product returns.</p>
</li>
</ol>
<p>Afterward, it was analyzed, and selected the following features to build the machine learning model:' customer_id', 'gross_revenue', 'recency_days', 'total_orders', 'frequency', and 'qty_returns'.</p>
<p>The main objective is to develop and implement a clustering machine learning algorithm based on the RFM model for a loyalty program. This will help group customers into different clusters, allowing for personalized marketing strategies and improved customer engagement.</p>
<p>The combination of embedding techniques and clustering algorithms creates an iterative refinement process. Embeddings group data points into preliminary clusters based on more informative representations, which are then fine-tuned by clustering algorithms to produce well-defined segments. This synergy enhances the overall quality and interpretability of the final clusters.</p>
<p>First, feature embedding techniques like PCA, t-SNE, UMAP, and tree-based embedding are used to capture subtle relationships and patterns. Then, for each type of embedding, clustering algorithms such as K-Means, GMM, Hierarchical Clustering, and DBSCAN are tested to find the optimal silhouette score. After a thorough evaluation, the Tree-Based embedding technique and GMM clustering algorithm are chosen as they provided the best results.</p>
<h2>RESULTS ANALYSIS</h2>
<p>[insert image]</p>
<p>The clusters are ordered by the highest average gross revenue, with cluster 2 having the best results. These highly engaged customers comprise around 8.89% of the total clientele. Their substantial average gross revenue of $15,857.94, average recency period of 11.88 days, and high interaction frequency showcase their strong interest in the offerings. However, their relatively high return quantity of 218.40 indicates possible purchase concerns.</p>
<p>When comparing cluster 2 with 5 (second in the ordering based on highest gross_revenue) can be observed that cluster 5 includes customers with moderate shopping behavior, placing an average of 8.48 orders. They have a low purchase frequency, with an average of 0.04, and a lower gross revenue of $3303.88. However, they exhibit solid engagement and have a low return rate, with only 53 returns and a 27-day interval between purchases.</p>
<p>[insert image]</p>
<h2>MODEL DEPLOYMENT</h2>
<p>The model deployment was built using the tools from the AWS environment and a Github repository, as seen in the image below.</p>
<p>[insert image]</p>
<p>At first, everything is tested locally creating the prototype of our project on the Jupyter Notebook and SQLite. That way it can be verified that our database will receive the right tables and values. Also, we can save our machine learning model in Pickle to serialize our model and send it directly to the S3 storage, if performance decreases we can revisit and improve our models.</p>
<p>After testing and validation, the project will be pushed to a GitHub repository linked to our EC2 instance running Ubuntu OS. A Cron Job will be scheduled to run a script that utilizes the papermill tool to execute our deploy notebook weekly. The output will be saved to a new notebook and send the updated data to our RDS Postgres database.</p>
<p>Finally, we can visualize the data of the clusters using Metabase locally which is connected directly to our RDS Database.</p>
<p>[insert image]</p>
<h2>NEXT STEPS</h2>
<p>Potential next steps and improvements for the loyalty program:</p>
<ul>
<li>Refining the clustering algorithm,</li>
<li>Integrating additional data sources,</li>
<li>Conducting A/B tests,</li>
<li>Continuously monitoring and updating the program based on customer behavior,</li>
<li>Feedback.</li>
</ul>
<hr />
<p>Feel free to contribute, provide feedback, and use the insights from this project to enhance customer engagement and drive the success of your loyalty program. If you have any questions or suggestions, please contact me at https://www.linkedin.com/in/gabriel-pastega/.</p>
