import { useState, useEffect } from 'react';
import UserList from '../components/UserList';
import UserModal from '../components/UserModal';
import ConfirmationModal from '../components/ConfirmationModal';
import { getUsers, addUser, deleteUser } from '../api';

function SpringBootPage() {
	const API_BASE_URL = `http://${import.meta.env.VITE_SPRINGBOOT_EC2_ADDRESS}/api/v1`;

	const [users, setUsers] = useState([]);
	const [selectedUser, setSelectedUser] = useState(null);
	const [showUserModal, setShowUserModal] = useState(false);
	const [showConfirmModal, setShowConfirmModal] = useState(false);

	useEffect(() => {
		getUsers(API_BASE_URL).then(data => setUsers(data));
	}, [API_BASE_URL]);

	const handleAddUser = (user) => {
		addUser(API_BASE_URL, user).then(newUser => setUsers([...users, newUser]));
		setShowUserModal(false);
	};

	const handleDeleteUser = (id) => {
		deleteUser(API_BASE_URL, id).then(() => setUsers(users.filter(user => user.id !== id)));
		setShowConfirmModal(false);
	};

	return (
		<div className="container">
			<h1>Spring Boot To-Do App</h1>
			<button className="btn btn-primary" onClick={() => setShowUserModal(true)}>
				Add User
			</button>

			<UserList
				API_BASE_URL={API_BASE_URL}
				users={users}
				setSelectedUser={setSelectedUser}
				setShowConfirmModal={setShowConfirmModal}
			/>

			<UserModal
				show={showUserModal}
				handleClose={() => setShowUserModal(false)}
				handleAddUser={handleAddUser}
			/>

			<ConfirmationModal
				show={showConfirmModal}
				handleClose={() => setShowConfirmModal(false)}
				handleConfirm={() => handleDeleteUser(selectedUser.id)}
				user={selectedUser}
			/>
		</div>
	);
}

export default SpringBootPage;