package meddoc.dev.genericUsage.genericService;

import meddoc.dev.genericUsage.genericModel.HasId;
import org.springframework.data.jpa.repository.JpaRepository;

public abstract class GenericService<E extends HasId ,ID> {
    protected JpaRepository<E, ID> repository;

    public void save(E model) {
        try{
            repository.save(model);
        }catch(Exception e) {
            throw e;
        }
    }
    public E findById(ID id) {
        try{
            return repository.findById(id).orElseThrow(
                    () -> new RuntimeException("get By id for : "+id+" on "+this.getClass()+" "+" is  not found"));
        }catch(Exception e) {
            throw e;
        }
    }
    public void deleteById(ID id) {
        try{
            repository.deleteById(id);
        }catch (Exception e) {
            throw e;
        }
    }
    public java.util.List<E> findAll() {
        try{
            return repository.findAll();
        }catch (Exception e){
            throw e;
        }

    }
    public abstract void setRepository(JpaRepository<E,ID> repository);


}
