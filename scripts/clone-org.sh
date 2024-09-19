for repo in $(curl https://api.github.com/users/$1/repos | jq -r '.[].full_name'); do
	echo git@gh-thesmartwon:$repo
	git clone git@gh-thesmartwon:$repo
done
