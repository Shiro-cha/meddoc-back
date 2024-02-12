package meddoc.dev.module.search.service;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.ElasticsearchTransport;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import lombok.Data;
import meddoc.dev.module.search.model.HasIndex;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Data
@Service
public class ElasticService {
    @Value("${elastic.search.apihost}")
    String apihost;
    @Value("${elastic.search.apiport}")
    int port;
    public ElasticsearchClient provideClient(){
        RestClient httpClient = RestClient.builder(
                new HttpHost("192.168.88.253", 9200)
        ).build();
        JacksonJsonpMapper mapper = new JacksonJsonpMapper();
        ElasticsearchTransport transport = new RestClientTransport(
                httpClient,
                mapper
        );
        ElasticsearchClient esClient = new ElasticsearchClient(transport);
        //ElasticsearchAsyncClient asyncEsClient= new ElasticsearchAsyncClient(transport);
        return esClient;
    }
    public<L extends HasIndex> void insert(L cSearch, String id) throws IOException {
        if(cSearch.getIndex()==null) throw new IOException("Index is null");
        ElasticsearchClient esClient= provideClient();
        esClient.index(buider -> buider
                .index(cSearch.getIndex())
                .id(id)
                .document(cSearch)
        );
    }
    public<L extends HasIndex> void update(L cSearch, String id) throws IOException {
        if(cSearch.getIndex()==null) throw new IOException("Index is null");
        ElasticsearchClient esClient= provideClient();
        esClient.update(u -> u.index(cSearch.getIndex())
                .id(id)
                .doc(cSearch), cSearch.getClass());
    }
    public void delete(String index,String id) throws IOException {
        ElasticsearchClient esClient= provideClient();
        esClient.delete(d -> d.index(index)
                .id(id));
    }
}
