import React from 'react';
import { TextField } from '@mui/material';

function FormField({ label, type = 'text', value, onChange }) {
  return (
    <TextField
      label={label}
      type={type}
      variant="outlined"
      margin="normal"
      fullWidth
      value={value}
      onChange={onChange}
    />
  );
}

export default FormField;
