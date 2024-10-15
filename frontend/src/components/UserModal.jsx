import { useState } from 'react';
import { Modal, Button } from 'react-bootstrap';

function UserModal({ show, handleClose, handleAddUser }) {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');

  const handleSubmit = () => {
    if (name && email) {
      handleAddUser({ name, email });
      setName('');
      setEmail('');
      handleClose();  // Close the modal after submission
    }
  };

  // Check if both name and email fields are filled
  const isFormValid = name.trim() !== '' && email.trim() !== '';

  return (
    <Modal show={show} onHide={handleClose}>
      <Modal.Header closeButton>
        <Modal.Title>Add User</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <input
          type="text"
          placeholder="Name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="form-control"
        />
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="form-control mt-3"
        />
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          Close
        </Button>
        {/* Disable Add User button if form is invalid */}
        <Button variant="primary" onClick={handleSubmit} disabled={!isFormValid}>
          Add User
        </Button>
      </Modal.Footer>
    </Modal>
  );
}

export default UserModal;