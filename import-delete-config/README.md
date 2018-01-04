Deleting datasets
=================

This readme file describes the useage of the ImPlex tool for deleting a lot of datasets in a database. You can also use the UniPlexDataservice (UPD) or JavaScript to do that. These options are explained for other database examples.

How to delete?
=============

To delete a lot of datasets with the ImPlex-Tool it's necessary to use the option `DeltaListe`. That means that the delta between updated and not updated datasets can handled with special functions.

	c = clear -  clears all values in the dataset, except the field content you declared as import reference
	l = delete - irreversible deletion of the complete dataset
	a = archive - archive the dataset in the way of the UniPlex does
	w = restorable delete -restorable deletion in the way the UniPlex does

To configure the `DeltaListe` you need to activate a new line in the `globel´ block of the configuration: 

	<Global>
		<LoginIP>______</LoginIP>
		<LoginPort>______</LoginPort>
		<LoginUser>______</LoginUser>
		<LoginPW>______</LoginPW>
		<ImportModus>______</ImportModus>
		<DeltaListe>l</DeltaListe>
	</Global>

The java call for the ImPlex-Tool is the same, as always

	Java -jar Implex.jar -i config_file_for_delete.xml
	
Reorganization
==============

After deleting a lot of datasets or repeating deletes in the database, you MUST do an reorganizsation with the admin tool `Remote Admin`. If you like to reduce the file size of the database file (tli-files) than you have to do a backup and recovery.
