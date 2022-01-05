echo "Update web app version"

GIT_USERNAME=$1
GIT_TOKEN=$2
WORK_DIR=$3
TAG=$4
GIT_EMAIL="thanuja.rashmi.tv@gmail.com"

mkdir helm_user_mgt_be

# Clone the repo to push changes to main branch.
git clone https://"${GIT_USERNAME}":"${GIT_TOKEN}"@github.com/IITCC/helm-user-mgt-be.git helm_user_mgt_be
git -C helm_user_mgt_be config user.email "${GIT_EMAIL}"
git -C helm_user_mgt_be config user.name "${GIT_USERNAME}"

TAG_LINE=$(grep -w 'tag' "${WORK_DIR}"/helm_user_mgt_be/values.yaml | sed 's/ *//')
sed -i 's|'"${TAG_LINE}"'|tag: '"'${TAG}'"'|' "${WORK_DIR}"/helm_user_mgt_be/values.yaml

# Push new values.yaml.
git -C helm_user_mgt_be add "${WORK_DIR}"/helm_user_mgt/values.yaml
git -C helm_user_mgt_be commit -m "Update user mgt app version to - ${TAG}"
git -C helm_user_mgt_be push origin main

echo "Update web app version done"
