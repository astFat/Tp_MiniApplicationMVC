<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Client" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Liste des Clients</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #f8f9fa;">

<div class="container mt-4">
    <div class="card">

        <div class="card-header text-white" style="background-color: #5B9BD5;">
            <h4 class="mb-0">Liste des Clients</h4>
        </div>

        <div class="card-body" style="background-color: #f8f9fa;">
            <form method="get" action="clients" class="d-flex align-items-center gap-2">
                <label class="fw-bold me-2">Client :</label>
                <input type="text" name="nom" class="form-control" style="max-width: 300px;"
                       value="<%= request.getAttribute("recherche") != null ? request.getAttribute("recherche") : "" %>">
                <button type="submit" class="btn text-white" style="background-color: #5B9BD5;">Chercher</button>
                <a href="clients?action=nouveau" class="btn text-white ms-auto" style="background-color: #F4B183;">Nouveau Client</a>
            </form>
        </div>

        <div class="card-body pt-0">
            <table class="table table-borderless">
                <thead>
                    <tr style="border-bottom: 2px solid #dee2e6;">
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Age</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Client> clients = (List<Client>) request.getAttribute("clients");
                    if (clients != null && !clients.isEmpty()) {
                        for (Client c : clients) {
                %>
                    <tr style="border-bottom: 1px solid #e0e0e0;">
                        <td><%= c.getId() %></td>
                        <td><%= c.getNom() %></td>
                        <td><%= c.getPrenom() %></td>
                        <td><%= c.getAge() %></td>
                        <td class="text-end">
                            <a href="clients?action=editer&id=<%= c.getId() %>" class="btn btn-success me-2">Éditer</a>
                            <a href="clients?action=supprimer&id=<%= c.getId() %>" class="btn btn-danger"
                               onclick="return confirm('Voulez-vous vraiment supprimer ce client ?');">Supprimer</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">Aucun client trouvé.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>