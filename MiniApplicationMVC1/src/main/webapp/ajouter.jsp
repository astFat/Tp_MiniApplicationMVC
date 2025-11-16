<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ajouter un Client</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #f8f9fa;">

<div class="container mt-4">
    <div class="card">
        <div class="card-header text-white" style="background-color: #5B9BD5;">
            <h4 class="mb-0">Nouveau Client</h4>
        </div>

        <div class="card-body">
            <form method="post" action="clients">
                <input type="hidden" name="action" value="ajouter">

                <div class="mb-3">
                    <label class="form-label fw-bold">ID Client :</label>
                    <input type="text" class="form-control" disabled style="background-color: #e9ecef;" placeholder="Auto-généré">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Nom Client :</label>
                    <input type="text" name="nom" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Prénom Client :</label>
                    <input type="text" name="prenom" class="form-control" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Age :</label>
                    <input type="number" name="age" class="form-control" required>
                </div>

                <div>
                    <button type="submit" class="btn text-white" style="background-color: #5B9BD5;">Ajouter</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
