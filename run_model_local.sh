# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')

#paths
path='/home/gabriel/repos/cluster_vips'
path_to_envs='/home/gabriel/.pyenv/versions/3.11.3/envs/clustervips/bin'

$path_to_envs/papermill $path/2.0_cluster_vips.ipynb $path/reports/2.0_deploy_$data.ipynb
