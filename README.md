# vidispine-gl-to-ado
Tools for migration from Gitlab to Azure DevOps

## Archive project to S3
The tool `archive-repo.sh` can be used to mirror a gitlab repository, create a tar-ball, push it to a S3-bucket and then archives the project in Gitlab

The tool requires aws-cli, lesume and a gitlab token.

### Syntax
```
chmod +x archive-repo.sh  
export $GITLAB_TOKEN=yourgitlabtoken  
lesume.sh sandbox 333333  
./archive-repo.sh vidispine/jenkins/build-scripts.git  
```
