package controller;

import model.Client;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/clients")
public class ClientServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/db_clients";
    private static final String USER = "root";
    private static final String PASSWORD = "root_pwd";
   
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL introuvable", e);
        }
    }
 
    private List<Client> listerClients(String recherche) {
        List<Client> clients = new ArrayList<>();
        String sql = "SELECT * FROM client WHERE nom LIKE ? ORDER BY id";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + (recherche != null ? recherche : "") + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                clients.add(new Client(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
                    rs.getInt("age")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clients;
    }
    
    private Client getClientParId(int id) {
        Client client = null;
        String sql = "SELECT * FROM client WHERE id=?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                client = new Client(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
                    rs.getInt("age")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return client;
    }
    
    private boolean ajouterClient(String nom, String prenom, int age) {
        String sql = "INSERT INTO client (nom, prenom, age) VALUES (?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, nom);
            ps.setString(2, prenom);
            ps.setInt(3, age);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean modifierClient(int id, String nom, String prenom, int age) {
        String sql = "UPDATE client SET nom=?, prenom=?, age=? WHERE id=?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, nom);
            ps.setString(2, prenom);
            ps.setInt(3, age);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean supprimerClient(int id) {
        String sql = "DELETE FROM client WHERE id=?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "liste";
        
        switch (action) {
            case "nouveau":
                request.getRequestDispatcher("ajouter.jsp").forward(request, response);
                break;
                
            case "editer":
                int id = Integer.parseInt(request.getParameter("id"));
                Client client = getClientParId(id);
                request.setAttribute("client", client);
                request.getRequestDispatcher("modifier.jsp").forward(request, response);
                break;
                
            case "supprimer":
                int idSuppr = Integer.parseInt(request.getParameter("id"));
                supprimerClient(idSuppr);
                response.sendRedirect("clients");
                break;
                
            default:
                String recherche = request.getParameter("nom");
                List<Client> clients = listerClients(recherche);
                request.setAttribute("clients", clients);
                request.setAttribute("recherche", recherche);
                request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        int age = Integer.parseInt(request.getParameter("age"));
        
        if ("ajouter".equals(action)) {
            ajouterClient(nom, prenom, age);
            
        } else if ("modifier".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            modifierClient(id, nom, prenom, age);
        }
      
        response.sendRedirect("clients");
    }
}