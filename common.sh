headings(){
  echo -e "\e[33m$1\e[0m"
}

status_check(){
  if [ $? -eq 0 ]; then
      echo -e "\e[32mSuccess\e[0m"
  else
    echo -e "\e[31mFailure\e[0m"
  fi
}
