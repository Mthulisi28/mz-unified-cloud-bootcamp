function vaultOpen(fileName, assetType, tier) {

    console.log(
        "Opening premium asset:",
        fileName,
        "| Type:",
        assetType,
        "| Tier:",
        tier
    );

    if (
        fileName.startsWith("http://") ||
        fileName.startsWith("https://")
    ) {
        window.open(fileName, "_blank");
        return;
    }

    window.open(
        "./assets/" + fileName,
        "_blank"
    );
}