using Toybox.System;
using Toybox.Lang;
using Toybox.Application.Storage;
using Toybox.Application.Properties;

function getProperty(key, defaultValue, type) {
	var value;
	var exception;

	try {
		exception = false;
		value = Properties.getValue(key);
	}
	catch (e) {
		exception = true;
		value = defaultValue;
	}

	if (exception) {
		try {
			Properties.setValue(key, defaultValue);
		}
		catch (e) {
		}
	}

	return type.invoke(value, defaultValue);
}

function validateNumber(value, defValue) {
	if (value == null || value instanceof Lang.Boolean) {
		return defValue;
	}

	try {
		value = value.toNumber();
		if (value == null) {
			value = defValue;
		}
	}
	catch (e) {
		value = defValue;
	}
	return value;
}

function validateBoolean(value, defValue) {
	if (value != null && value instanceof Lang.Boolean) {
		try {
			value = (value == true);
		}
		catch (e) {
			value = defValue;
		}
		return value;
	}
	else {
		return defValue;
	}
}
