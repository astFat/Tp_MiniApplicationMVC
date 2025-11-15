<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Client" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Modifier Client</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #f8f9fa;">

<div class="container mt-4">
    <%
        Client client = (Client) request.getAttribute("client");
        if (client == null) {
    %>
        <div class="alert alert-danger">
            Client introuvable !
            <a href="clients" class="btn btn-sm btn-secondary mt-2">Retour</a>
        </div>
    <%
        } else {
    %>
    
    <div class="card">
        <div class="card-header text-white" style="background-color: #5B9BD5;">
            <h4 class="mb-0">Mettre à jour les informations du client</h4>
        </div>

        <div class="card-body">
            <form method="post" action="clients">
                <input type="hidden" name="action" value="modifier">
                <input type="hidden" name="id" value="<%= client.getId() %>">

                <div class="mb-3">
                    <label class="form-label fw-bold">Nom Client :</label>
                    <input type="text" name="nom" class="form-control" value="<%= client.getNom() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Prénom Client :</label>
                    <input type="text" name="prenom" class="form-control" value="<%= client.getPrenom() %>" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Age :</label>
                    <input type="number" name="age" class="form-control" value="<%= client.getAge() %>" required>
                </div>

                <div>
                    <button type="submit" class="btn text-white" style="background-color: #5B9BD5;">Modifier</button>
                    <a href="clients" class="btn btn-secondary">Annuler</a>
                </div>
            </form>
        </div>
    </div>
    
    <%
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>