MANIFEST_FILE=manifest.json
TF_TFVARS_FILE=../terraform-azure/terraform.tfvars

# Name extraction - Base of the script
IMAGE_NAME=$(jq -r '.builds[-1].artifact_id' $MANIFEST_FILE | cut -d ':' -f2 | cut -d '/' -f9)
echo "Image name :" $IMAGE_NAME

#Set var in TFVAR file inside Terraform
sed -i '' "/^packer_image/s/=.*/=\""$IMAGE_NAME"\"/" $TF_TFVARS_FILE
cat $TF_TFVARS_FILE
