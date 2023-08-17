exports = async function(changeEvent) {
  const collection = context.services.get('mongodb-atlas').db('Draw').collection('Drawing');
  try {
      await collection.insertOne({author: changeEvent.fullDocument.author, name: changeEvent.fullDocument.name});
  } catch(err) {
    console.log("Error adding ${changeEvent.fullDocument.name}: ", err.message);
  }
};
