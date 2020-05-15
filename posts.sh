#!/usr/bin/env bash

source token.sh

METHOD=$1
OPT1=$2

TAG="posts/?filter=tag:$2"
AUTHOR="posts/?filter=author:$2"
ALL="&limit=all"

case $1 in 
        browse )
		curl -H "Authorization: Ghost $TOKEN"\
		-H "Content-Type: application/json"\
		-G $URL${API}posts/ | jq
                ;;
	browse-al )
		curl -H "Authorization: Ghost $TOKEN"\
                -H "Content-Type: application/json"\
                -G $URL${API}posts/?limit=all | jq
		;;
	browse-tags )
		curl -H "Authorization: Ghost $TOKEN"\
                -H "Content-Type: application/json"\
                -G $URL$API$TAG | jq
		;;
	browse-tags-all )
		curl -H "Authorization: Ghost $TOKEN"\
                -H "Content-Type: application/json"\
                -G $URL${API}$TAG$ALL | jq
                ;;
	browse-authors )
		curl -H "Authorization: Ghost $TOKEN"\
                -H "Content-Type: application/json"\
                -G $URL${API}$AUTHOR | jq
                ;;
	browse-authors-all )
		curl -H "Authorization: Ghost $TOKEN"\
                -H "Content-Type: application/json"\
                -G $URL${API}$AUTHOR$ALL | jq
                ;;
	delete-tags )
		read -p "Are you sure you want to delete all posts in tag $2?" yn
		case $yn in
			[Yy]* )
				ID=$(curl -H "Authorization: Ghost $TOKEN" -H "Content-Type: application/json" -G "$URL$API$TAG$ALL" | jq -r '.posts[].id')
				counter=0
				for i in $ID
				do
					curl	-H "Authorization: Ghost $TOKEN" \
						-H "Content-Type: application/json" \
						-X DELETE \
						$URL${API}posts/$i	

					(( counter++ ))
				done
				exit 0
				;;
			* )
				exit 0
				;;
		esac
		;;
        * )
                echo "Please use a valid argument."
                ;;
esac

exit 0
