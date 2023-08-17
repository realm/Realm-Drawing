exports = async function(changeEvent) {
  const collection = context.services.get('mongodb-atlas').db('Draw').collection('Drawing');
  try {
    if (changeEvent.operationType === "delete") {
      await collection.deleteOne({author: changeEvent.fullDocumentBeforeChange.author, name: changeEvent.fullDocumentBeforeChange.name});
    }
  } catch(err) {
    console.log("Error deleting ${changeEvent.fullDocumentBeforeChange.name}: ", err.message);
  }
};
