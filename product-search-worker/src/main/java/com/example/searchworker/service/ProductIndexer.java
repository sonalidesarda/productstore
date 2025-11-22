package com.example.searchworker.service;

import com.example.searchworker.model.Product;
import org.apache.solr.client.solrj.impl.Http2SolrClient;
import org.apache.solr.common.SolrInputDocument;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class ProductIndexer {

    private final Http2SolrClient solrClient;

    public ProductIndexer(@Value("${solr.url}") String solrUrl) {
        this.solrClient = new Http2SolrClient.Builder(solrUrl).build();
    }

    @KafkaListener(topics = "products", groupId = "search-worker-group")
    public void listen(Product product) {
        System.out.println("Received product: " + product);
        try {
            SolrInputDocument doc = new SolrInputDocument();
            doc.addField("id", product.getId().toString());
            doc.addField("name", product.getName());
            doc.addField("sku", product.getSku());
            doc.addField("description", product.getDescription());
            doc.addField("price", product.getPrice());

            // Solr might need specific configuration for dynamic fields, but basic fields
            // usually work if schema is flexible or managed
            // For simplicity, we assume a default config or that we can add these fields.
            // In a real setup, we'd define the schema.

            solrClient.add("products", doc);
            solrClient.commit("products");
            System.out.println("Indexed product: " + product.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
