#!/bin/sh

cd ..

java -jar Implex.jar -i ./www/import-config/import-colors.xml
java -jar Implex.jar -i ./www/import-config/import-part_categories.xml
java -jar Implex.jar -i ./www/import-config/import-themes.xml
java -jar Implex.jar -i ./www/import-config/import-sets.xml
java -jar Implex.jar -i ./www/import-config/import-inventories.xml
java -jar Implex.jar -i ./www/import-config/import-parts.xml
java -jar Implex.jar -i ./www/import-config/import-inventory_parts.xml
java -jar Implex.jar -i ./www/import-config/import-inventory_sets.xml

java -jar Implex.jar -l ./www/import-config/Linker.xml
