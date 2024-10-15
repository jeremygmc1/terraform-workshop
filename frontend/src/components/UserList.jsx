import TodoList from './TodoList';

function UserList({ API_BASE_URL, users, setSelectedUser, setShowConfirmModal }) {
  return (
    <div>
      {users.map(user => (
        <div key={user.id} className="card mt-3">
          <div className="card-title">
            <h4 className="username">{user.name}</h4>
            <button
              className="btn btn-danger"
              onClick={() => {
                setSelectedUser(user);
                setShowConfirmModal(true);
              }}>
              Delete User
            </button>
          </div>
          <TodoList API_BASE_URL={API_BASE_URL} userId={user.id} />
        </div>
      ))}
    </div>
  );
}

export default UserList;