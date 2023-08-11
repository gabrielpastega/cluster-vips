# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')

#paths
path='/ubuntu/cluster_vips'
path_to_envs='/ubuntu/.pyenv/versions/3.11.3/envs/clustervips/bin'

$path_to_envs/papermill $path/3.0_cluster_vips_DEPLOY.ipynb $path/reports/3.0_cluster_vips_DEPLOY_$data.ipynb
