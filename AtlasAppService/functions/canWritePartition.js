exports = function(partition) {
  console.log(`Checking if can sync a read for partition = ${partition}`);
  const user = context.user.data.email;
  console.log(`Checking if partition(${partition}) matches user(user=${user})`);
  return partition === `user=${user}`;
};