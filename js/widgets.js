publishedVersions = widgetsData.versions.filter(function(version){
	return version.published === true;
});
latestVersion = widgetsData.versions.filter(function(version){
	return version.published === true && version.latest === true ;
});
currentVersion = $('#docsVersion').attr("content");
currentVersionData = widgetsData.versions.find( version => version.title === currentVersion);
console.log(currentVersionData);
$(function(){
	$("#templates").load("/js/templates.html"); 
});
