# shell-scripting

#sed editior

# sed with -i edit the file
#sed without -i its print the change on output

# -e is for multiple conditions in sed command
# -e cond1 -e con2

#search and replace or substitute

sed -i -e 's/root/ROOT/g' -e 's/admin/ADMIN/g' sample.txt

