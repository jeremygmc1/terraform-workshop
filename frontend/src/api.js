const OP = `http://${import.meta.env.VITE_EC2_ADDRESS}/api/v1`;

// Fetch all users
export const getUsers = async (API_BASE_URL) => {
  const response = await fetch(`${API_BASE_URL}/users`);
  if (!response.ok) {
    throw new Error('Failed to fetch users');
  }
  return response.json();
};

// Add a new user with name and email
export const addUser = async (API_BASE_URL, user) => {
  const response = await fetch(`${API_BASE_URL}/users`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(user)  // user contains name and email
  });
  if (!response.ok) {
    throw new Error('Failed to add user');
  }
  return response.json();
};

// Update a user by ID with name and email (similar to addUser but using PATCH)
export const updateUser = async (API_BASE_URL, id, user) => {
  const response = await fetch(`${API_BASE_URL}/users/${id}`, {
    method: 'PATCH',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(user)  // user contains name and email
  });
  if (!response.ok) {
    throw new Error('Failed to update user');
  }
  return response.json();
};

// Delete a user by ID
export const deleteUser = async (API_BASE_URL, id) => {
  const response = await fetch(`${API_BASE_URL}/users/${id}`, { method: 'DELETE' });
  if (!response.ok) {
    throw new Error('Failed to delete user');
  }
};

// Fetch todos for a specific user
export const getTodosByUserId = async (API_BASE_URL, userId) => {
  const response = await fetch(`${API_BASE_URL}/todos?userId=${userId}`);
  if (!response.ok) {
    throw new Error('Failed to fetch todos for user');
  }
  return response.json();
};

// Add a new todo (task) for a user
export const addTodo = async (API_BASE_URL, todo) => {
  const response = await fetch(`${API_BASE_URL}/todos`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(todo)  // todo contains description, completed, and userId
  });
  if (!response.ok) {
    throw new Error('Failed to add todo');
  }
  return response.json();
};

// Fetch all todos
export const getTodos = async (API_BASE_URL) => {
  const response = await fetch(`${API_BASE_URL}/todos`);
  if (!response.ok) {
    throw new Error('Failed to fetch todos');
  }
  return response.json();
};

// Delete a todo by ID
export const deleteTodo = async (API_BASE_URL, id) => {
  const response = await fetch(`${API_BASE_URL}/todos/${id}`, { method: 'DELETE' });
  if (!response.ok) {
    throw new Error('Failed to delete todo');
  }
};