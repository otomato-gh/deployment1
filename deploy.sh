#! /bin/bash

print_title(){
	echo "Deploy Srcipt"
}

print_date(){
	echo "Date: $(date +"%d-%m-%y %H-%M-%S")"
}
# pass package name to function
install_package(){
	sudo apt-get install -y $1
}
apt_update(){
	sudo apt-get update
}
remove_old_site(){
	if [ ! -d /var/www/html/.git ]; then
          sudo rm -f /var/www/html/index.html
	fi
}
clone_website_code(){
	if [ ! -d /var/www/html/.git ]; then
	 sudo git clone https://github.com/octocat/Spoon-Knife /var/www/html/
	fi
}
check_apache(){
	servstat=$(service apache2 status)
	if [[ $servstat == *"active (running)"* ]]; then
  		echo -e "-------------------\nprocess is running"
	   else echo -e "-------------------\nprocess is not running"
	fi
}
pull_request(){
        if [ -d /var/www/html/ ]; then
          git add .
          git commit -m "FIXED"
          git push origin/main 
        fi
}

print_title
echo "-------------------------------------"
print_date
echo "-------------------------------------"
apt_update
echo "-------------------------------------"
install_package git
echo "-------------------------------------"
install_package apache2
echo "-------------------------------------"
check_apache
remove_old_site
echo "-------------------------------------"
clone_website_code
pull_request
echo "-------------------------------------"