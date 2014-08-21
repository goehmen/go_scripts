#!/bin/bash

cf api api.a1.cf-app.com --skip-ssl-validation
cf login -u admin -p sk1N875job -o go-76995182 -s go-space1


for space in `cf spaces | grep -E "^dev-space"`;
do
  cf target -s $space
    echo $space
    echo "apps: " 
    cf apps |wc -l
    echo "services: "
    cf services |wc -l
    echo "routes: "
    cf routes |wc -l
    echo " "
done


# permissions
# cf login -u admin -p admin
# cf target -o -large-org
# cf set-org-role dreinhold@pivotallabs.com heavy-org OrgManager
# cf set-org-role admin heavy-org OrgManager

# for space in `cf spaces | grep -E "^dev-space"`;
# do
  # yes yes | cf delete-space $space
  # cf target -s $space

  # cf set-space-role dreinhold@pivotallabs.com heavy-org $space SpaceDeveloper
  # cf set-space-role dreinhold@pivotallabs.com heavy-org $space SpaceManager
# done
