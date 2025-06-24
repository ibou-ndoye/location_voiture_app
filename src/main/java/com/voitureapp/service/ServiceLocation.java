package com.voitureapp.service;

import com.voitureapp.dao.LocationDAO;
import com.voitureapp.model.Location;

import java.util.List;

public class ServiceLocation {

    private LocationDAO locationDAO = new LocationDAO();

    public void ajouterLocation(Location location) {
        locationDAO.create(location);
    }

    public Location getLocationById(int id) {
        return locationDAO.findById(id);
    }

    public List<Location> getToutesLesLocations() {
        return locationDAO.findAll();
    }

    public void modifierLocation(Location location) {
        locationDAO.update(location);
    }

    public void supprimerLocation(int id) {
        locationDAO.delete(id);
    }

    public void fermer() {
        locationDAO.close();
    }
}
